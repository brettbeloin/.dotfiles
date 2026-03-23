return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("telescope").setup({
        -- Optional: add your Telescope settings here
        defaults = {
          layout_config = {
            horizontal = { width = 0.9 },
          },
        },
      })

      -- Optional: load Telescope extensions here
      -- require("telescope").load_extension("fzf")
    end,
  },
}
