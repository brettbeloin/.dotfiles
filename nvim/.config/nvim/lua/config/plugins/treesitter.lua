local ts_parsers = {
    "bash",
    "c",
    "dockerfile",
    "fish",
    "git_config",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "go",
    "gomod",
    "gosum",
    "json",
    "lua",
    "make",
    "markdown",
    "python",
    "rust",
    "toml",
    "vim",
    "yaml",
}

local nts = require("nvim-treesitter")
nts.install(ts_parsers)

vim.api.nvim_create_autocmd('PackChanged', {
    callback = function()
        nts.update()
    end
})

require("telescope").load_extension("fzf")
require("treesitter-context").setup({
    max_lines = 3,
    multiline_threshold = 1,
    separator = '-',
    min_window_height = 20,
    line_numbers = true,
})

require("neoscroll").setup({ duration_multiplier = 0.4 })
require("gitlinker").setup({})

vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        local filetype = args.match
        if filetype == "" then return end -- Skip empty filetype

        local lang = vim.treesitter.language.get_lang(filetype)
        if not lang then return end -- Skip if no language mapping

        if vim.treesitter.language.add(lang) then
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            vim.treesitter.start()
        end
    end
})
