return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      kotlin_language_server = {
        on_attach = function(client)
          client.server_capabilities.documentHighlightProvider = false
        end,
      },
    },
  },
}
