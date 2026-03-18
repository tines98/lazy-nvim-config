-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- Move text up and down
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
-- Norwegian keyboard: map å and ¨ to [ and ] namespaces
vim.keymap.set("n", "å", "[", { remap = true })
vim.keymap.set("n", "¨", "]", { remap = true })
vim.keymap.set("o", "å", "[", { remap = true })
vim.keymap.set("o", "¨", "]", { remap = true })
vim.keymap.set("x", "å", "[", { remap = true })
vim.keymap.set("x", "¨", "]", { remap = true })
