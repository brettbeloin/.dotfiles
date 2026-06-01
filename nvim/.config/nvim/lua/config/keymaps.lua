vim.g.mapleader = ' '

vim.keymap.set('n', '<leader>w', ':set wrap!<CR>', { desc = "toggle wrap lines" })
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Exit to file tree :Ex" })
vim.keymap.set("n", "<leader>so", vim.cmd.so, { desc = "Source current file :so" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])
vim.keymap.set('n', '<leader>sv', ':vsplit | terminal<CR>', { desc = "open virtical terminal" })
vim.keymap.set('n', '<leader>sh', ':split | terminal<CR>', { desc = "open horizantal terminal" })

-- vim.keymap.set("n", "<leader>et", ":NvimTreeToggle<CR>", { desc = "toggle file tree" })
vim.keymap.set("n", "<leader>ct", function()
    if vim.g.copilot_enabled == false then
        vim.cmd("Copilot enable")
        print("Copilot enabled")
    else
        vim.cmd("Copilot disable")
        print("Copilot disabled")
    end
end, { desc = "Toggle Copilot" })
