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
    vim.opt.titlestring = "<b>" .. project .. "</b> |" .. (file ~= "" and " • " .. file or "")
    vim.opt.title = true
  end,
})
vim.api.nvim_create_autocmd("DirChanged", {
  pattern = "global",
  callback = function()
    -- Search upward from cwd for .iterm-color
    local color_file = vim.fn.findfile(".iterm-color", ".;")

    if color_file == "" then
      -- Reset to default tab color
      io.write("\x1b]6;1;bg;*;default\a")
      io.flush()
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

    -- Convert hex to r/g/b components in 0-65535 range (iTerm2 uses 16-bit)
    local r = tonumber(hex:sub(1, 2), 16)
    local g = tonumber(hex:sub(3, 4), 16)
    local b = tonumber(hex:sub(5, 6), 16)

    -- Send iTerm2 proprietary escape sequence to set tab color
    local seq = string.format(
      "\x1b]6;1;bg;red;brightness;%d\a" .. "\x1b]6;1;bg;green;brightness;%d\a" .. "\x1b]6;1;bg;blue;brightness;%d\a",
      r,
      g,
      b
    )
    io.write(seq)
    io.flush()
  end,
})
