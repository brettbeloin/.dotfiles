vim.g.mapleader = ' '

vim.cmd("command! W w")
vim.cmd("command! X x")
vim.cmd("command! Q q")
vim.cmd("command! Wq wq")

vim.keymap.set('n', '<leader>w', ':set wrap!<CR>', { desc = "toggle wrap lines" })
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Exit to file tree :Ex" })
vim.keymap.set("n", "<leader>so", vim.cmd.so, { desc = "Source current file :so" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])
vim.keymap.set('n', '<leader>sv', ':vsplit | terminal<CR>', { desc = "open virtical terminal" })
vim.keymap.set('n', '<leader>sh', ':split | terminal<CR>', { desc = "open horizantal terminal" })
vim.keymap.set('n', '<S-CR>', 'o<Esc>', { desc = "Insert line below" })

vim.keymap.set('n', '<leader>ng', ':Neogit<CR>', { desc = "Enters neogit" })

vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "copy line to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "copy muliple lines to system clipboard" })

-- vim.keymap.set("n", "<leader>et", ":NvimTreeToggle<CR>", { desc = "toggle file tree" })
vim.keymap.set("n", "<leader>ct", function()
    if vim.g.copilot_enabled then
        vim.cmd("Copilot disable")
        print("Copilot disabled")
    else
        vim.cmd("Copilot enable")
        print("Copilot enabled")
    end
end, { desc = "Toggle Copilot" })
