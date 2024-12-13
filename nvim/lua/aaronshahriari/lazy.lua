local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    {
        "tjdevries/colorbuddy.nvim",
    },
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v4.x",
        dependencies = {
            { "neovim/nvim-lspconfig" },
        }
    },
    { "norcalli/nvim-colorizer.lua" },
    {
        "hrsh7th/nvim-cmp",
        lazy = false,
        priority = 100,
        dependencies = {
            "onsails/lspkind.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
            "saadparwaiz1/cmp_luasnip",
        },
    },
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        "epwalsh/obsidian.nvim",
        version = "*", -- recommended, use latest release instead of latest commit
        lazy = true,
        ft = "markdown",
        dependencies = {
            -- Required.
            "nvim-lua/plenary.nvim",
        },
    },
    "tpope/vim-surround",
    {
        "chomosuke/term-edit.nvim",
        lazy = false,
        version = '1.*',
    },
    {
        "echasnovski/mini.ai",
        version = "*"
    },

    "folke/todo-comments.nvim",

    "nvim-lua/plenary.nvim",

    "numToStr/Comment.nvim",

    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.4",
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    -- new theme
    { "bluz71/vim-moonfly-colors",  name = "moonfly", lazy = false, priority = 1000 },
    {
        "nvim-treesitter/nvim-treesitter",
        tag = "v0.9.2",
        build = ":TSUpdate",
    },

    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" }
    },

    "mbbill/undotree",
    "tpope/vim-fugitive",

    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },

    "lukas-reineke/indent-blankline.nvim",
})
