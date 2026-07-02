require("config.editor.options")
require("config.editor.keymaps")

require("plugins.pack")

-- Setup plugins after pack loads them
vim.schedule(function()
    -- editor
    require("config.editor.diagnostics")
    require("config.editor.terminal")
    -- plugins
    require("config.plugins.harpoon")
    require("config.plugins.telescope")
    require("config.plugins.treesitter")
    require("config.plugins.lsp")
    require("config.plugins.cmp")
    require("config.plugins.which-key")
    require("config.plugins.gitsigns")
    require("config.plugins.neogit")
    require("config.plugins.copilot")
    -- integrations
    require("config.integrations.conform")
    require("config.integrations.lint")
    require("config.integrations.comment")
    require("config.integrations.comment_string")
    require("config.integrations.autopairs")
    -- Extra
    require("config.extras.whitespace")
end)
