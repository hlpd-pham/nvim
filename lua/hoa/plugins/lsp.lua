require("nvim-lsp-installer").setup()
local lsp = require("lsp-zero")
lsp.preset("recommended")

lsp.ensure_installed({
	"rust_analyzer",
	"pyright",
	"gopls",
})

-- Fix Undefined global 'vim'
lsp.nvim_workspace()

-- configuration for golang
require("lspconfig").gopls.setup({
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
			gofumpt = true,
		},
	},
})

local debounce_timer = nil
require("lspconfig").rust_analyzer.setup({
	settings = {
		["rust-analyzer"] = {
			diagnostics = {
				enable = true,
			},
			checkOnSave = {
				enable = false, -- Disable on-save checks
			},
		},
	},
	handlers = {
		["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
			if debounce_timer then
				debounce_timer:stop()
				debounce_timer:close()
			end

			debounce_timer = vim.defer_fn(function()
				vim.lsp.handlers["textDocument/publishDiagnostics"](nil, result, ctx, config)
			end, 5000) -- 5000ms = 5 seconds
		end,
	},
})

require("lspconfig").clangd.setup({})
require("lspconfig").pyright.setup({
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
			},
			-- uncomment this line and add python env
			pythonPath = "/Users/hoapham/workspace/kelp/kelp_dagster/.venv/bin/python3",
			-- pythonPath = "/Users/hoapham/workspace/local-python/bin/python3",
		},
	},
})

-- general lsp stuffs
local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
	["<C-y>"] = cmp.mapping.confirm({ select = true }),
	["<C-Space>"] = cmp.mapping.complete(),
})

lsp.setup_nvim_cmp({
	mapping = cmp_mappings,
})

lsp.set_preferences({
	suggest_lsp_servers = false,
	sign_icons = {
		error = "E",
		warn = "W",
		hint = "H",
		info = "I",
	},
})

lsp.on_attach(function(_, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, opts)
	vim.keymap.set("n", "<leader>vws", function()
		vim.lsp.buf.workspace_symbol()
	end, opts)
	vim.keymap.set("n", "<leader>vd", function()
		vim.diagnostic.open_float()
	end, opts)
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.goto_next()
	end, opts)
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.goto_prev()
	end, opts)
	vim.keymap.set("n", "<leader>vca", function()
		vim.lsp.buf.code_action()
	end, opts)
	vim.keymap.set("n", "<leader>vrr", function()
		vim.lsp.buf.references()
	end, opts)
	vim.keymap.set("n", "<leader>vrn", function()
		vim.lsp.buf.rename()
	end, opts)
end)

lsp.setup()

vim.diagnostic.config({
	virtual_text = true,
})
