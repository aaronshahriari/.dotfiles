return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = { 'L3MON4D3/LuaSnip', version = 'v2.*' },
    opts = {
      snippets = { preset = 'luasnip' },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      keymap = { preset = "default" },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono"
      },
      completion = {
        list = {
          selection = {
            preselect = true,
            auto_insert = false,
          },
        },
        documentation = {
          auto_show = true,
          window = {
            border = "single",
          },
        },
      },

      signature = { enabled = true }
    },
    opts_extend = { "sources.default" }
  },
}
