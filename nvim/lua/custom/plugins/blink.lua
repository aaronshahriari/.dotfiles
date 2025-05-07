return {
  {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",
    version = "1.*",
    -- build = 'nix run .#build-plugin',
    opts = {
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      keymap = { preset = "default" },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono"
      },
      completion = {
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
