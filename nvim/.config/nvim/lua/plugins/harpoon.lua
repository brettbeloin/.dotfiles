return {
  {
    "ThePrimeagen/harpoon",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      -- Optional: put your harpoon config here
      require("harpoon").setup()
    end,
  },
}
