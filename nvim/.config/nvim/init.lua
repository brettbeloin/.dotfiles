require("config.options")
require("config.keymaps")

require("plugins.pack")

-- Setup plugins after pack loads them
vim.schedule(function()
    require("harpoon").setup()
    require("config.harpoon")
    require("config.telescope")
    require("config.treesitter")
    require("config.lsp")
    require('Comment').setup(require("config.comment"))
end)
