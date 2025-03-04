local gitblame = require("gitblame")
gitblame.setup({
	--Note how the `gitblame_` prefix is omitted in `setup`
	enabled = false,
})

vim.keymap.set("n", "<leader>gb", "<cmd>GitBlameToggle<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>gbf", "<cmd>GitBlameOpenFileURL<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>gbc", "<cmd>GitBlameOpenCommitURL<CR>", { noremap = true, silent = true })

-- {
--   copy_commit_url_to_clipboard = <function 1>,
--   copy_file_url_to_clipboard = <function 2>,
--   copy_sha_to_clipboard = <function 3>,
--   disable = <function 4>,
--   enable = <function 5>,
--   get_current_blame_text = <function 6>,
--   get_sha = <function 7>,
--   is_blame_text_available = <function 8>,
--   open_commit_url = <function 9>,
--   open_file_url = <function 10>,
--   setup = <function 11>,
--   toggle = <function 12>
-- }
