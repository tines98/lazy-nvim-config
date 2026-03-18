return {
  {
    "sainnhe/gruvbox-material",
    config = function()
      -- gruvbox-material specific settings must come BEFORE colorscheme is set
      vim.g.gruvbox_material_visual = "reverse" -- or "grey background", "blue background", etc.
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox-material", -- or "kanagawa-wave", "everforest", etc.
    },
  },
}
