local gh = function(x) return 'https://github.com/' .. x end

vim.pack.add({
    -- short imneanias/everforest-nvimport
    gh("nvim-lua/plenary.nvim"),
    gh("ThePrimeagen/vim-be-good"),
    gh("ThePrimeagen/harpoon"),
    gh("nvim-telescope/telescope.nvim"),
    gh("nvim-treesitter/nvim-treesitter-context"),
    gh("neovim/nvim-lspconfig"),
    gh("ibhagwan/fzf-lua"),
    gh("christoomey/vim-tmux-navigator"),
    gh("karb94/neoscroll.nvim"),
    gh("ruifm/gitlinker.nvim"),
    gh("folke/which-key.nvim"),
    gh("neanias/everforest-nvim"),
    gh("numToStr/Comment.nvim"),
    gh("hrsh7th/nvim-cmp"),
    gh("hrsh7th/cmp-nvim-lsp"),
    gh("hrsh7th/cmp-buffer"),
    gh("hrsh7th/cmp-path"),
    gh("stevearc/conform.nvim"),
    gh("mfussenegger/nvim-lint"),
    gh('johnfrankmorgan/whitespace.nvim'),
    gh('github/copilot.vim'),

    -- table imports
    { src = gh("nvim-treesitter/nvim-treesitter"), version = 'main' },
    {
        src = gh("nvim-telescope/telescope-fzf-native.nvim"),
        hooks = {
            post_checkout = function()
                vim.system({ "make" }):wait()
            end,
        },
    },
})
