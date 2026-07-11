-- Editor options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.shell = "/usr/bin/bash"
vim.opt.spell = true
vim.opt.spelllang = { "en_us" }

-- vim.api.nvim_create_autocmd("VimEnter", {
--     callback = function()
--         if vim.fn.argc() == 0 then
--             vim.cmd("Oil")
--         end
--     end,
-- })
--
-- Colorscheme
vim.cmd.colorscheme("everforest")
