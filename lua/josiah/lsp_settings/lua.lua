require("neodev").setup({
  library = { plugins = { "nvim-dap-ui" }, types = true },
})

require'lspconfig'.lua_ls.setup {}
