local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-t>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
    }, {
        { name = "buffer" },
    }),
})

vim.keymap.set({ "i", "s" }, "<C-r>", function()
    if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    end
end)

vim.keymap.set({ "i", "s" }, "<C-S-r>", function()
    if luasnip.jumpable(-1) then
        luasnip.jump(-1)
    end
end)
