vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- general keymaps
keymap.set("i", "jk", "<ESC>")

-- toggle no hls
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- open explorer
keymap.set("n", "<leader>", ":Ex<CR>")

-- merge lines
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

keymap.set("n", "x", '"_x')

-- increment and decrement
keymap.set("n", "<leader>+", "<C-a>")
keymap.set("n", "<leader>-", "<C-x>")

keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- split window equal width
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<Tab>", ":tabn<CR>") -- go to next tab
keymap.set("n", "<S-Tab>", ":tabp<CR>") -- go to prev tab

-- half page jumping
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

-- keep search term in the middle
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- Just don't do anything with capital q
keymap.set("n", "Q", "<nop>")

keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- toggle line wrap
keymap.set("n", "<C-w>", ":set wrap!<CR>")

-- copy pasta magic
keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
keymap.set({ "n", "v" }, "<leader>y", [["+y]]) -- copy paragraph
keymap.set("n", "<leader>Y", [["+Y]]) -- copy line

keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end)
