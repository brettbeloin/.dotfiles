-- build projects

vim.keymap.set("n", "<leader>rb", ":vsplit | terminal cmake --build build<CR>",
    { desc = "build cmake project" })

vim.keymap.set("n", "<leader>rc",
    ":vsplit | terminal rm -rf build/ && cmake -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON && cmake --build build<CR>",
    { desc = "Rebuild a Cmake Project" })

vim.keymap.set("n", "<leader>rr", function()
    local build_dir = "build"
    local executables = {}

    for file in io.popen("find " .. build_dir .. " -maxdepth 1 -type f -executable"):lines() do
        table.insert(executables, file)
    end

    if #executables == 0 then
        print("No executable found in build directory")
        return
    end

    local cmd = "cmake --build " .. build_dir .. " && " .. executables[1]
    vim.cmd("vsplit | terminal " .. cmd)
end, { desc = "Run cmake executable" })
