---@diagnostic disable: unused-function, unused-local
local builtin = require("telescope.builtin")
-- project files instead of find files
vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set("n", "<leader>ps", function()
	builtin.grep_string({ search = vim.fn.input("Grep >") })
end)
vim.keymap.set("n", "<leader>pd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>fs", require("telescope.builtin").lsp_document_symbols, { desc = "[D]ocument [S]ymbols" })
vim.keymap.set("n", "gt", require("telescope.builtin").lsp_type_definitions, { desc = "Type [D]efinition" })

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

function live_grep_with_pattern()
	require("telescope.builtin").live_grep({
		default_text = vim.fn.input("Pattern: "),
	})
end

-- Key mapping to trigger the function
vim.api.nvim_set_keymap("n", "<leader>fg", ":lua live_grep_with_pattern()<CR>", { noremap = true, silent = true })

-- stole from https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
vim.api.nvim_create_user_command("Format", function()
	vim.lsp.buf.format()
end, { desc = "Format current buffer with LSP" })
