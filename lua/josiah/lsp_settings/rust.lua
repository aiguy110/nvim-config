require("lspconfig").rust_analyzer.setup({})

local rt = require("rust-tools")

local function get_inlay_toggle_closure()
	local inlays_on = false

	return function()
		if inlays_on then
			rt.inlay_hints.unset()
			inlays_on = false
		else
			rt.inlay_hints.set()
			inlays_on = true
		end
	end
end

rt.setup({
	tools = {
		inlay_hints = {
			auto = false,
		},
	},
	server = {
		on_attach = function(_, bufnr)
			-- Hover actions
			vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })

			-- Let Inlay Hints be toggled
			vim.keymap.set("n", "<C-i>", get_inlay_toggle_closure(), { buffer = bufnr })

			-- Code action groups
			--vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
		end,
	},
})
