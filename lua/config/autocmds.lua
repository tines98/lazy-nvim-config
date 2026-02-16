-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*gitui*",
  callback = function()
    vim.cmd([[
      hi Terminal guibg=#1a1b26 guifg=#c0caf5
      hi TermCursor guibg=#7aa2f7 guifg=#1a1b26
    ]])
  end,
})
