local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>pf", function()
    builtin.find_files({ cwd = vim.fn.expand("%:p:h") })
end, { desc = "Telescope find files in current file dir" })

vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>ps", function()
    builtin.grep_string({ search = vim.fn.input("Find: ") }) 
end)
