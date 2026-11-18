require("which-key").setup({
    show_help = true,
    triggers = {
        { "<leader>", mode = "nxsov" }, -- Remove "c" (command mode)
    },
})
