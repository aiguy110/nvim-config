-- Let Mason install any language servers we requested
-- and then update nvim-lspconfig settings so it knows
-- how to launch them.
require("mason").setup()
require("mason-lspconfig").setup()

-- Update default lspconfig settings to include capabilities
-- from cmp plugin
local lspconfig = require("lspconfig")
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities =
	vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

-- Try inlay hints
require("lsp-inlayhints").setup()

-- Bind LSP-related keymappings for a buffer only when
-- we attach to and LSP server
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		local opts = { buffer = true }

		vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
		vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
		vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
		vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
		vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
		vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
		vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
		vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
		vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
		vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)

		vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
		vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
		vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)

		vim.keymap.set("n", "<Leader>lo", ":lua vim.diagnostic.open_float()<CR>")
		vim.keymap.set("n", "<Leader>ln", ":vim.diagnostic.goto_next()<CR>")
		vim.keymap.set("n", "<Leader>lp", ":vim.diagnostic.goto_prev()<CR>")

        vim.o.signcolumn = "yes"
	end,
})

require("josiah.lsp_settings.python")
require("josiah.lsp_settings.rust")
require("josiah.lsp_settings.lua")
