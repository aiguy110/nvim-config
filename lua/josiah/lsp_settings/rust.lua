require'lspconfig'.rust_analyzer.setup{
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        enable = true; -- true by default; just doing this for example purposes
      }
    }
  }
}
