-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	-- Telescope fuzzy finder
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.1',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	-- Onedark color scheme
	use { 'navarasu/onedark.nvim', config = function()
		require('onedark').load()
	end }

	-- Treesitter for better syntax highlighting and whatnot
	use( 'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'} )
	use 'nvim-treesitter/playground'

	-- Harpoon for faster file navication
	use 'theprimeagen/harpoon'

	-- Undo tree
	use 'mbbill/undotree'

	-- Universal commenting
	use 'tpope/vim-commentary'

	-- Quick LSP setup
	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		requires = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},             -- Required
			{                                      -- Optional
			'williamboman/mason.nvim',
			run = function()
				pcall(vim.cmd, 'MasonUpdate')
			end,
		},
		{'williamboman/mason-lspconfig.nvim'}, -- Optional

		-- Autocompletion
		{'hrsh7th/nvim-cmp'},     -- Required
		{'hrsh7th/cmp-nvim-lsp'}, -- Required
		{'L3MON4D3/LuaSnip'},     -- Required

	},

	-- More LSP stuff
	use {
		'jose-elias-alvarez/null-ls.nvim',
		config = function()
			local null_ls = require('null-ls')
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.prettier.with({
						filetypes = { "html", "json", "yaml", "markdown" },
					}),
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.diagnostics.eslint,
					null_ls.builtins.completion.spell,
				}
			})
		end
    	},

	-- Nerdtree for better fs navigation
	use 'preservim/nerdtree',

	-- In-editor terminal
	use {"akinsho/toggleterm.nvim", tag = '*', config = function()
		require("toggleterm").setup {
			open_mapping = [[<C-\>]]
		}
	end
	},
}

end)
