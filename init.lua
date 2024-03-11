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
	{
		"folke/neodev.nvim",
		opts = {}
	},
	{
		"neovim/nvim-lspconfig",
	},
    {
        "folke/tokyonight.nvim",
        lazy = true, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            vim.cmd([[colorscheme tokyonight]])
        end,
    },
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		config = function()
            vim.cmd([[colorscheme kanagawa-wave]])
        end,
	},
    {
		'nvim-telescope/telescope.nvim',
		tag = '0.1.5',
		lazy = true,
		dependencies = { 'nvim-lua/plenary.nvim' },
	 	cmd = "Telescope"
    },
	{
        {
			"nvim-treesitter/nvim-treesitter",
			ensure_installed = { "lua", "vim", "vimdoc", "query", "markdown" },
			cmd = {"TSUpdate", "TSInstall"},
			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = false,
			build = ":TSUpdate",
		}
	},
    {
		"nvim-tree/nvim-tree.lua",
		cmd = {"NvimTreeToggle", "NvimTreeFocus"},
        version = "*",
        dependencies = {
			"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
        require("nvim-tree").setup {}
        end,
    }, 
    {
        'romgrk/barbar.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
        },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {
            sidebar_filetypes = {
                NvimTree = true,
			}
		},
		cmd = {"BufferNext", "BufferPrevious", "BufferClose"},
        version = '^1.0.0', -- optional: only update when a new 1.x version is released
    },
    {
        'stevearc/oil.nvim',
		cmd = "Oil",
        opts = {},
        -- Optional dependencies
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        'numToStr/Comment.nvim',
        opts = {
			-- add any options here
        },
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
        "tpope/vim-fugitive",
		cmd = "Git"
    },	
	{
		'dstein64/vim-startuptime',
		cmd = "StartupTime"
	},
	{
	  "christoomey/vim-tmux-navigator",
	  cmd = {
		"TmuxNavigateLeft",
		"TmuxNavigateDown",
		"TmuxNavigateUp",
		"TmuxNavigateRight",
	  },
	  keys = {
		{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
		{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
		{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
		{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
	  },
	}
})

require'lspconfig'.clangd.setup{
	-- Add setup here
}

-- Key Bindings
local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap
local vmap = vim.keymap.set

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
