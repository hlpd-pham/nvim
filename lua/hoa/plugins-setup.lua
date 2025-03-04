local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

-- Autocommand that reloads neovim whenever you save this file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
	return
end

return packer.startup(function(use)
	use("wbthomason/packer.nvim")

	-- lua functions that many plugins use
	use("nvim-lua/plenary.nvim")

	use("bluz71/vim-nightfly-guicolors") -- preferred colorscheme

	-- tmux & split window navigation
	use("christoomey/vim-tmux-navigator")

	use("szw/vim-maximizer")

	-- commenting with gc
	use("numToStr/Comment.nvim")

	-- fuzzy finder
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		-- or                            , branch = '0.1.x',
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
	use("nvim-treesitter/playground")
	use("mbbill/undotree")
	use("tpope/vim-fugitive")

	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("williamboman/nvim-lsp-installer")

	-- Formatting
	use("stevearc/conform.nvim")

	-- LSP Support
	use("neovim/nvim-lspconfig")

	-- Completion framework:
	use("hrsh7th/nvim-cmp")

	-- LSP completion source:
	use("hrsh7th/cmp-nvim-lsp")

	-- case coercion https://vimtricks.com/p/vimtrick-text-case-coercion/
	use("tpope/vim-abolish")

	-- Useful completion sources:
	use("hrsh7th/cmp-nvim-lua")
	use("hrsh7th/cmp-nvim-lsp-signature-help")
	use("hrsh7th/cmp-vsnip")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/vim-vsnip")

	-- the best plugin
	use({
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-- setup lsp zero
	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		requires = {

			-- Autocompletion
			{ "L3MON4D3/LuaSnip" }, -- Required
		},
	})

	-- Add indentation guides even on blank lines
	use({
		"lukas-reineke/indent-blankline.nvim",
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help ibl`
		main = "ibl",
		opts = {},
	})

	-- debugger
	use("mfussenegger/nvim-dap")
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } })

	-- git blame
	use("f-person/git-blame.nvim")

	-- use("leoluz/nvim-dap-go")
	-- use({ "mxsdev/nvim-dap-vscode-js", requires = { "mfussenegger/nvim-dap" } })

	-- use({
	-- 	"mrcjkb/rustaceanvim",
	-- 	version = "^5", -- Recommended
	-- 	lazy = false, -- This plugin is already lazy
	-- 	ft = "rust",
	-- 	config = function()
	-- 		require("rustaceanvim").setup({
	-- 			dap = {
	-- 				adapter = require("rustaceanvim.config").get_codelldb_adapter(
	-- 					"/Users/hoapham/workspace/codelldb/extension/adapter/codelldb", -- Path to codelldb executable
	-- 					"/Users/hoapham/workspace/codelldb/extension/lldb/lib/liblldb.dylib" -- Path to liblldb.dylib
	-- 				),
	-- 			},
	-- 		})
	-- 	end,
	-- })

	if ensure_packer() then
		require("packer").sync()
	end
end)
