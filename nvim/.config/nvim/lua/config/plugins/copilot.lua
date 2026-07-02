vim.keymap.set("n", "<leader>ct", function()
    if vim.g.copilot_enabled then
        vim.cmd("Copilot disable")
        print("Copilot disabled")
    else
        vim.cmd("Copilot enable")
        print("Copilot enabled")
    end
end, { desc = "Toggle Copilot" })
