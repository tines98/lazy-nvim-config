-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- Move text up and down
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
-- Norwegian keyboard: map å and æ to [ and ] namespaces
vim.keymap.set("n", "å", "[", { remap = true })
vim.keymap.set("n", "æ", "]", { remap = true })
vim.keymap.set("o", "å", "[", { remap = true })
vim.keymap.set("o", "æ", "]", { remap = true })
vim.keymap.set("x", "å", "[", { remap = true })
vim.keymap.set("x", "æ", "]", { remap = true })

-- Open iTerm2 vertical split in current project directory
map("n", "<leader>tv", function()
  local cwd = vim.fn.getcwd()
  vim.fn.system("ttab -v -i -d " .. cwd)
end, { desc = "iTerm2 vertical split (cwd)" })

map("n", "<leader>th", function()
  local cwd = vim.fn.getcwd()
  vim.fn.system("ttab -h -i -d " .. cwd)
end, { desc = "iTerm2 horizontal split (cwd)" })
