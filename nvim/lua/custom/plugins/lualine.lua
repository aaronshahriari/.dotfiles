return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local colors = {
      blue   = '#89b4fa',
      cyan   = '#94e2d5',
      black  = '#1e1e2e',
      white  = '#cdd6f4',
      red    = '#f38ba8',
      violet = '#cba6f7',
      grey   = '#313244',
    }

    -- local bubbles_theme = {
    --   normal = {
    --     a = { fg = colors.black, bg = colors.violet },
    --     b = { fg = colors.white, bg = colors.grey },
    --     c = { fg = colors.white },
    --   },
    --
    --   insert = { a = { fg = colors.black, bg = colors.blue } },
    --   visual = { a = { fg = colors.black, bg = colors.cyan } },
    --   replace = { a = { fg = colors.black, bg = colors.red } },
    --
    --   inactive = {
    --     a = { fg = colors.white, bg = '#181825' },
    --     b = { fg = colors.white, bg = '#181825' },
    --     c = { fg = colors.white, bg = '#181825' },
    --   },
    -- }

    local basic_theme = {
      normal = {
        a = { fg = colors.white, bg = colors.grey },
        b = { fg = colors.white, bg = colors.grey },
        c = { fg = colors.white, bg = colors.grey },
      },

      insert = {
        a = { fg = colors.white, bg = colors.grey },
        b = { fg = colors.white, bg = colors.grey },
        c = { fg = colors.white, bg = colors.grey },
      },

      visual = {
        a = { fg = colors.white, bg = colors.grey },
        b = { fg = colors.white, bg = colors.grey },
        c = { fg = colors.white, bg = colors.grey },
      },

      replace = {
        a = { fg = colors.white, bg = colors.grey },
        b = { fg = colors.white, bg = colors.grey },
        c = { fg = colors.white, bg = colors.grey },
      },

      inactive = {
        a = { fg = colors.white, bg = '#181825' },
        b = { fg = colors.white, bg = '#181825' },
        c = { fg = colors.white, bg = '#181825' },
      },
    }

    require('lualine').setup {
      options = {
        -- theme = bubbles_theme,
        theme = basic_theme,
        component_separators = '',
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { { 'branch', icon = { '', color = { fg = 'grey' } } }, 'diagnostics' },
        lualine_c = {
          '%=',
          {
            'filename',
            file_status = true,
            newfile_status = false,
            path = 4,
          },
        },
        lualine_x = {},
        lualine_y = { 'filetype' },
        lualine_z = { 'location' },
      },
      inactive_sections = {
        lualine_a = {
          {
            'filename',
            file_status = true,
            newfile_status = false,
            path = 4,
          },
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'location' },
      },
      tabline = {},
      extensions = {},
    }
  end
}
