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

local function find_build_executable()
    local build_dir = "build"
    local handle = io.popen("find " .. build_dir .. " -maxdepth 1 -type f -executable 2>/dev/null")
    if not handle then return nil end

    local executable = handle:lines()()
    handle:close()
    return executable
end

dap.configurations.cpp = {
    {
        name = "Launch",
        type = "gdb",
        request = "launch",
        program = function()
            return find_build_executable() or vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build/", "file")
        end,
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
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

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
