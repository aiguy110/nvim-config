-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")

    -- Telescope fuzzy finder
    use({
        "nvim-telescope/telescope.nvim",
        tag = "0.1.1",
        requires = { { "nvim-lua/plenary.nvim" } },
    })

    -- Onedark color scheme
    use({
        "navarasu/onedark.nvim",
        config = function()
            require("onedark").load()
        end,
    })

    -- Treesitter for better syntax highlighting and whatnot
    use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
    use("nvim-treesitter/playground")

    -- Harpoon for faster file navication
    use("theprimeagen/harpoon")

    -- Undo tree
    use("mbbill/undotree")

    -- Universal commenting
    use({
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup({
                toggler = {
                    line = '<leader>cc',
                    block = '<leader>bc',
                },
                opleader = {
                    line = '<leader>c',
                    block = '<leader>b',
                },
            })
        end
    })

    -- LSP setup
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")
    use("neovim/nvim-lspconfig")

    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-nvim-lsp-signature-help")
    use("hrsh7th/vim-vsnip")
    use("lvimuser/lsp-inlayhints.nvim")
    use("simrat39/rust-tools.nvim")

    -- More LSP stuff
    use({
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.prettier.with({
                        filetypes = { "html", "json", "yaml", "markdown" },
                    }),
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.diagnostics.eslint,
                    null_ls.builtins.completion.spell,
                },
            })
        end,
    })
    use("folke/neodev.nvim")

    -- Nerdtree for better fs navigation
    use("preservim/nerdtree")

    -- In-editor terminal
    use({
        "akinsho/toggleterm.nvim",
        tag = "*",
        config = function()
            require("toggleterm").setup({
                open_mapping = [[<C-\>]],
            })
        end,
    })

    -- Remote editing
    use({
        "chipsenkbeil/distant.nvim",
        branch = "v0.2",
        config = function()
            local default_settings = require("distant.settings").chip_default()
            default_settings.ssh = {
                other = {
                    StrictHostKeyChecking = "no",
                },
            }
            require("distant").setup({
                -- Applies Chip's personal settings to every machine you connect to
                --
                -- 1. Ensures that distant servers terminate with no connections
                -- 2. Provides navigation bindings for remote directories
                -- 3. Provides keybinding to jump into a remote file's parent directory

                ["*"] = default_settings,
            })
        end,
    })

    -- lazygit
    use({
        "kdheepak/lazygit.nvim",
        requires = { "nvim-lua/plenary.nvim" }
    })

    -- Debug Adapter Protocol client
    use("mfussenegger/nvim-dap")
    use("mfussenegger/nvim-dap-python")
    use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
end)
