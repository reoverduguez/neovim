vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap.set

keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc ="Clears search result highlighting" })

-- Window navigation
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

keymap("n", "<C-d>", "<C-d>zz", { desc = "Keep cursor centered when moving down" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Keep cursor centered when moving up" })

keymap("v", ">", ">gv", { desc = "Indent selection and keep focus" })
keymap("v", "<", "<gv", { desc = "De-indent selection and keep focus" })

