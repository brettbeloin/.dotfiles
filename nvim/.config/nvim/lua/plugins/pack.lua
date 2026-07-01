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
    gh("folke/ts-comments.nvim"),
    gh("neanias/everforest-nvim"),
    gh("hrsh7th/nvim-cmp"),
    gh("hrsh7th/cmp-nvim-lsp"),
    gh("hrsh7th/cmp-buffer"),
    gh("hrsh7th/cmp-path"),
    gh("stevearc/conform.nvim"),
    gh("mfussenegger/nvim-lint"),
    gh('johnfrankmorgan/whitespace.nvim'),
    gh('github/copilot.vim'),
    gh("windwp/nvim-autopairs"),
    gh("L3MON4D3/LuaSnip"),
    gh("saadparwaiz1/cmp_luasnip"),
    gh("JoosepAlviste/nvim-ts-context-commentstring"),
    gh("williamboman/mason.nvim"),
    gh("williamboman/mason-lspconfig.nvim"),
    gh("NeogitOrg/neogit"),
    gh("lewis6991/gitsigns.nvim"),
    -- gh("tpope/vim-fugitive"),
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
