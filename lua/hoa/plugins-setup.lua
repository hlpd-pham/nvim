local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
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
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  use('nvim-treesitter/playground')
  use('mbbill/undotree')
  use('tpope/vim-fugitive')
  use('kyazdani42/nvim-web-devicons')
  use('kyazdani42/nvim-tree.lua')

  use('williamboman/mason.nvim')
  use('williamboman/mason-lspconfig.nvim')
  use('williamboman/nvim-lsp-installer')


  -- LSP Support
  use('neovim/nvim-lspconfig')

    -- Completion framework:
  use('hrsh7th/nvim-cmp')

  -- LSP completion source:
  use('hrsh7th/cmp-nvim-lsp')

  -- case coercion https://vimtricks.com/p/vimtrick-text-case-coercion/
  use('tpope/vim-abolish')

  -- Useful completion sources:
  use('hrsh7th/cmp-nvim-lua')
  use('hrsh7th/cmp-nvim-lsp-signature-help')
  use('hrsh7th/cmp-vsnip')
  use('hrsh7th/cmp-path')
  use('hrsh7th/cmp-buffer')
  use('hrsh7th/vim-vsnip')

  -- the best plugin
  use('ThePrimeagen/harpoon')

  -- setup lsp zero
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {

    -- Autocompletion
    {'L3MON4D3/LuaSnip'},     -- Required
  }

}

  if ensure_packer() then
    require("packer").sync()
  end
end)
