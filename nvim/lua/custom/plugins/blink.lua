return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = { 'L3MON4D3/LuaSnip', version = 'v2.*' },
    opts = {
      snippets = { preset = 'luasnip' },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        per_filetype = {
          sql = { 'snippets', 'dadbod', 'buffer' },
        },
        -- add vim-dadbod-completion to your completion providers
        providers = {
          dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
        },
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

      signature = {
        enabled = true,
        window = {
          min_width = 1,
          max_width = 100,
          max_height = 10,
          border = "single",
        },
      },
    },
    opts_extend = { "sources.default" }
  },
}
