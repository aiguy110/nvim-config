require'lspconfig'.pylsp.setup{
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
            enabled = false
        }
      }
    }
  }
}
