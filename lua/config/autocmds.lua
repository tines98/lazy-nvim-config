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
vim.api.nvim_create_autocmd({ "DirChanged" }, {
  callback = function()
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    vim.opt.titlestring = " " .. project_name
    vim.opt.title = true
  end,
})
vim.api.nvim_create_autocmd("DirChanged", {
  pattern = "global",
  callback = function()
    local utils = require("config.utils")
    local project = utils.getProject()
    -- if project is nil then set colors to NONE
    if not project then
      vim.fn.system("kitten @ set-tab-color " .. "active_bg=NONE " .. "inactive_bg=NONE ")
      return
    end

    -- Extract the color values
    local active_bg = project.active_tab_color or "NONE"
    local inactive_bg = project.inactive_tab_color or active_bg

    -- Set the kitten values
    vim.fn.system("kitten @ set-tab-color " .. "active_bg=" .. active_bg .. " inactive_bg=" .. inactive_bg)
  end,
})

-- set title string on vim startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.opt.titlestring = " " .. "LazyVim"

    vim.opt.title = true
  end,
})
