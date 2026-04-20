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
    require("config.cmp")
end)

--[[
-- software that needs to be instlled:
-- 	clang
-- 	linux-headers
-- 	base-devel
-- 	ccls
--      go install golang.org/x/tools/gopls@latest
--      golang: go to website and install
--      rustup component add rust-analyzer
--      cargo install tree-sitter-cli
--]]
