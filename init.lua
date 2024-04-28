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
vim.opt.laststatus = 0

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
        lazy = true,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme tokyonight]])
        end,
    },
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
        priority = 1000,
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
			ensure_installed = { "lua", "vim", "vimdoc", "query", "markdown", "glsl" },
			cmd = {"TSUpdate", "TSInstall"},
			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = false,
			build = ":TSUpdate",
			highlight = {
				enable = true,
			},
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
	},
	{
		"ray-x/web-tools.nvim",
		config = function()
			require('web-tools').setup({
				keymaps = {
					rename = nil,  -- by default use same setup of lspconfig
					-- repeat_rename = '.', -- . to repeat
				},
				hurl = {  -- hurl default
					show_headers = false, -- do not show http headers
					floating = false,   -- use floating windows (need guihua.lua)
					json5 = false,      -- use json5 parser require json5 treesitter
					formatters = {  -- format the result by filetype
					  json = { 'jq' },
					  html = { 'prettier', '--parser', 'html' },
					},
				},
			})
		end,
	},
	{
		"rhysd/conflict-marker.vim"
	},
	{
		'jiangmiao/auto-pairs'
	}
})

-- require'lspconfig'.clangd.setup{
-- 	-- Add setup here
-- }

-- Key Bindings
local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap
local vmap = vim.keymap.set

-- Telescope
vmap("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
vmap("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
vmap("n", "<leader>gp", "<cmd>Telescope live_grep<cr>")

-- NvimTree
vmap("n", "<C-n>", "<cmd>NvimTreeToggle<cr>")
vmap("n", "<leader>e", "<cmd>NvimTreeFocus<cr>")

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
