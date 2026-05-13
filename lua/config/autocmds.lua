-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
-- vim.api.nvim_create_autocmd("TermOpen", {
--   pattern = "*gitui*",
--   callback = function()
--     vim.cmd([[
--       hi Terminal guibg=#1a1b26 guifg=#c0caf5
--       hi TermCursor guibg=#7aa2f7 guifg=#1a1b26
--     ]])
--   end,
-- })
vim.api.nvim_create_autocmd({ "DirChanged", "BufEnter" }, {
  callback = function()
    local project = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    local file = vim.fn.expand("%:t")
    vim.opt.titlestring = "[" .. project .. "]" .. file
    vim.opt.title = true
  end,
})
vim.api.nvim_create_autocmd("DirChanged", {
  pattern = "global",
  callback = function()
    local color_file = vim.fn.findfile(".iterm-color", ".;")

    if color_file == "" then
      vim.print(vim.fn.system("kitten @ set-tab-color active_bg=NONE inactive_bg=NONE"))
      return
    end

    local f = io.open(color_file, "r")
    if not f then
      return
    end

    local hex = f:read("*l"):gsub("^#", ""):gsub("%s+", "")
    f:close()

    if #hex ~= 6 then
      return
    end

    vim.print(vim.fn.system("kitten @ set-tab-color active_bg=#" .. hex .. " inactive_bg=#" .. hex))
  end,
})
