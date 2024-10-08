---@diagnostic disable: unused-function, unused-local
local builtin = require("telescope.builtin")
-- project files instead of find files
vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set("n", "<leader>ps", function()
	builtin.grep_string({ search = vim.fn.input("Grep >") })
end)
vim.keymap.set("n", "<leader>pd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })

require("telescope").setup({
	defaults = {
		file_ignore_patterns = {
			"node_modules",
		},
		find_command = {
			"fd",
			"--type",
			"f",
			"--no-ignore-vcs",
			"--color=never",
			"--hidden",
			"--follow",
		},
	},
})

-- stole from https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
local on_attach = function(_, bufnr)
	-- NOTE: Remember that lua is a real programming language, and as such it is possible
	-- to define small helper and utility functions so you don't have to repeat yourself
	-- many times.
	--
	-- In this case, we create a function that lets us more easily define mappings specific
	-- for LSP related items. It sets the mode, buffer and description for us each time.
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

	-- Jump to the type of the word under your cursor.
	--  Useful when you're not sure what type a variable is and you want to see
	--  the definition of its *type*, not where it was *defined*.
	nmap("gt", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

	-- Fuzzy find all the symbols in your current document.
	--  Symbols are things like variables, functions, types, etc.
	nmap("<leader>fs", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, { desc = "Format current buffer with LSP" })
end
