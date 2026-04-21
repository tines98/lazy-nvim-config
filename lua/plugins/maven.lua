return {
  "oclay1st/maven.nvim",
  cmd = { "Maven", "MavenInit", "MavenExec", "MavenFavorites" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  opts = {}, -- options, see default configuration
  keys = {
    { "<leader>M", desc = "+Maven", mode = { "n", "v" } },
    { "<leader>Mm", "<cmd>Maven<cr>", desc = "Maven Projects" },
    { "<leader>Mf", "<cmd>MavenFavorites<cr>", desc = "Maven Favorite Commands" },
  },
}
