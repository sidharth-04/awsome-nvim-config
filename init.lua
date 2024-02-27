vim.g.mapleader = " "
vim.g.localleader = "\\"

vim.wo.number = true
vim.wo.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.swapfile = false
vim.opt.compatible = false
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"

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

require("lazy").setup({
    { "folke/neoconf.nvim", cmd = "Neoconf" },
    "folke/neodev.nvim",
    {
        "folke/tokyonight.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- load the colorscheme here
            vim.cmd([[colorscheme tokyonight]])
        end,
    },
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
         dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        {"nvim-treesitter/nvim-treesitter",     ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false, build = ":TSUpdate", lazy=true}},
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
        require("nvim-tree").setup {}
        end,
    },
    {
        "alexghergh/nvim-tmux-navigation",
        event = "VeryLazy",
        config = function()
            require'nvim-tmux-navigation'.setup {
                disable_when_zoomed = true
            }
        end,
    },
    {
        'romgrk/barbar.nvim',
        dependencies = {
            'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
            'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
        },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {
            sidebar_filetypes = {
                NvimTree = true,
            },
        },
        version = '^1.0.0', -- optional: only update when a new 1.x version is released
    },
    {
        'stevearc/oil.nvim',
        opts = {},
        -- Optional dependencies
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        'numToStr/Comment.nvim',
        opts = {
                -- add any options here
        },
        lazy = false,
    },
    {
        'neovim/nvim-lspconfig'
    },
    {
        'simrat39/rust-tools.nvim'
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },
    {
        "lewis6991/gitsigns.nvim",
        config=function()
			require("gitsigns").setup()
        end,
    },
    {
        "tpope/vim-fugitive"
    },
	{
	  'stevearc/conform.nvim',
	  opts = {},
	},
	{
		'dstein64/vim-startuptime'
	}
})

-- Rust Setup
local rt = require("rust-tools")
rt.setup({
    server = {
        on_attach = function(_, bufnr)
            -- Hover actions
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
        end,
    },
})

-- Conform Setup
require("conform").setup({
	notify_on_error=false,
  	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		javascript = { { "prettierd", "prettier" } },
  	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
  	},
})

-- Key Bindings
local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap
local vmap = vim.keymap.set

-- Nvim Tmux Navigation
vmap('n', "<C-h>", "<cmd>NvimTmuxNavigateLeft<cr>")
vmap('n', "<C-j>", "<cmd>NvimTmuxNavigateDown<cr>")
vmap('n', "<C-k>", "<cmd>NvimTmuxNavigateUp<cr>")
vmap('n', "<C-l>", "<cmd>NvimTmuxNavigateRight<cr>")

-- Telescope
vmap("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
vmap("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
vmap("n", "<leader>gp", "<cmd>Telescope live_grep<cr>")
map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)

-- NvimTree
vmap("n", "<C-n>", "<cmd>NvimTreeToggle<cr>")
vmap("n", "<leader>e", "<cmd>NvimTreeFocus<cr>")

-- Barbar
vmap("n", "<leader>,", "<cmd>BufferNext<cr>")
vmap("n", "<leader>.", "<cmd>BufferPrevious<cr>")
vmap("n", "<leader>c", "<cmd>BufferClose<cr>")

-- Oil
map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Mardown Preview
vmap("n", "<leader>mp", "<cmd>MarkdownPreview<cr>")
vmap("n", "<leader>mc", "<cmd>MarkdownPreviewStop<cr>")

-- Neorg
map('n', "<leader>nw", "'<cmd>Neorg workspace ' . input('Enter workspace: ') . '<cr>'", {expr = true, noremap = true})

-- Gitsigns
map('n', "[h", "<cmd>Gitsigns prev_hunk<cr>", opts)
map('n', "]h", "<cmd>Gitsigns next_hunk<cr>", opts)
map('n', "<leader>gs", "<cmd>Gitsigns preview_hunk_inline<cr>", opts)
