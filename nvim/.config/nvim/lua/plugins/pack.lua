local gh = function(x) return 'https://github.com/' .. x end

vim.pack.add({
    gh("nvim-lua/plenary.nvim"),
    gh("ThePrimeagen/vim-be-good"),
    gh("ThePrimeagen/harpoon"),
    gh("nvim-telescope/telescope.nvim"),
    {src = gh("nvim-treesitter/nvim-treesitter"), version = 'main' },
    gh("nvim-treesitter/nvim-treesitter-context"),
    gh("neovim/nvim-lspconfig"),
    gh("ibhagwan/fzf-lua"),
    gh("christoomey/vim-tmux-navigator"),
    gh("karb94/neoscroll.nvim"),
    gh("ruifm/gitlinker.nvim"),
    {
       src = gh("nvim-telescope/telescope-fzf-native.nvim"),
       hooks = {
           post_checkout = function()
               vim.system({"make"}):wait()
           end,
       },
   },
})
