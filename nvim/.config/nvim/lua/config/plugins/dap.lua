local dap = require("dap")
local dapui = require("dapui")

dap.adapters.gdb = {
    id = "gdb",
    type = "executable",
    command = "gdb",
    args = { "-i", "dap" },
}
-- alias so project .vscode/launch.json files using the vscode-cpptools
-- adapter name ("cppdbg") resolve to our native gdb DAP adapter
dap.adapters.cppdbg = dap.adapters.gdb

local function find_in_dir(dir, depth)
    local handle = io.popen("find " .. vim.fn.shellescape(dir) .. " -maxdepth " .. depth .. " -type f -executable 2>/dev/null")
    if not handle then return {} end

    local results = {}
    for line in handle:lines() do
        table.insert(results, line)
    end
    handle:close()
    return results
end

-- Looks for a build executable in common cmake output dirs first, then
-- falls back to plain g++/make-style output sitting in the project root
-- (e.g. `g++ main.cpp -o app`), so non-cmake projects work too.
local function find_build_executables()
    local cmake_dirs = { "build", "cmake-build-debug", "cmake-build-release" }
    for _, dir in ipairs(cmake_dirs) do
        if vim.fn.isdirectory(dir) == 1 then
            local found = find_in_dir(dir, 2)
            if #found > 0 then return found end
        end
    end
    return find_in_dir(".", 1)
end

-- GDB silently rejects breakpoints (and the session looks like it just
-- dies) when the binary has no DWARF debug info, e.g. compiled without -g.
local function warn_if_missing_debug_info(path)
    local handle = io.popen("readelf -S " .. vim.fn.shellescape(path) .. " 2>/dev/null")
    if not handle then return end
    local output = handle:read("*a")
    handle:close()
    if output and not output:find("debug_info") then
        vim.notify(
            "dap: '" .. path .. "' has no debug info (compile with -g) - breakpoints will be rejected",
            vim.log.levels.WARN
        )
    end
end

local function pick_executable()
    local candidates = find_build_executables()
    local path
    if #candidates == 0 then
        path = vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    elseif #candidates == 1 then
        path = candidates[1]
    else
        local co = coroutine.running()
        -- schedule_wrap matters: the default vim.ui.select (no picker
        -- plugin) resolves synchronously via vim.fn.inputlist, which would
        -- resume `co` before it has yielded below and leave it suspended
        -- forever with nothing to wake it back up.
        vim.ui.select(candidates, { prompt = "Select executable to debug:" }, vim.schedule_wrap(function(choice)
            coroutine.resume(co, choice)
        end))
        path = coroutine.yield()
    end
    if path and path ~= "" then
        warn_if_missing_debug_info(path)
    end
    return path
end

dap.configurations.cpp = {
    {
        name = "Launch",
        type = "gdb",
        request = "launch",
        program = pick_executable,
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = false,
    },
    {
        name = "Attach to process",
        type = "gdb",
        request = "attach",
        pid = function()
            return require("dap.utils").pick_process()
        end,
        cwd = "${workspaceFolder}",
    },
}
dap.configurations.c = dap.configurations.cpp

dap.adapters.sharpdbg = {
    type = "executable",
    command = "sharpdbg",
    args = { "--interpreter=vscode" },
}

dap.configurations.cs = {
    {
        type = "sharpdbg",
        name = "Launch",
        request = "launch",
        program = function()
            return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopAtEntry = false,
    },
}

dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
-- Deliberately not auto-closing dapui on terminated/exited: if the program
-- runs with no breakpoints set, it exits almost instantly and closing the
-- UI immediately makes it look like debugging silently did nothing. Close
-- manually with <leader>du once you've seen the output/state.

vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticSignWarn" })

-- Visual Studio style debug keybinds
vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: start/continue" })
vim.keymap.set("n", "<S-F5>", dap.terminate, { desc = "Debug: stop" })
vim.keymap.set("n", "<C-S-F5>", dap.restart, { desc = "Debug: restart" })
vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, { desc = "Debug: toggle breakpoint" })
vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: step over" })
vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: step into" })
vim.keymap.set("n", "<S-F11>", dap.step_out, { desc = "Debug: step out" })

vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "Dap toggle repl" })
vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Dap toggle ui" })
