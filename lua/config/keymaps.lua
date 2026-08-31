vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap.set

keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc ="Clears search result highlighting" })

keymap("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move to down window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move to up window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

keymap("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
keymap("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })

keymap("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
keymap("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
keymap("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
keymap("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

keymap("n", "<C-d>", "<C-d>zz", { desc = "Keep cursor centered when moving down" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Keep cursor centered when moving up" })

keymap("v", ">", ">gv", { desc = "Indent selection and keep focus" })
keymap("v", "<", "<gv", { desc = "De-indent selection and keep focus" })
