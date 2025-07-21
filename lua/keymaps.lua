vim.g.mapleader = " "

-- Telescope keymaps
local builtin = require('telescope.builtin')

-- File finding
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help tags' })

-- Git
vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Git files' })
vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = 'Git commits' })
vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'Git branches' })

-- LSP (if you use LSP)
vim.keymap.set('n', '<leader>lr', builtin.lsp_references, { desc = 'LSP references' })
vim.keymap.set('n', '<leader>ld', builtin.lsp_definitions, { desc = 'LSP definitions' })
vim.keymap.set('n', '<leader>ls', builtin.lsp_document_symbols, { desc = 'Document symbols' })
vim.keymap.set('n', '<leader>lw', builtin.lsp_workspace_symbols, { desc = 'Workspace symbols' })

-- Useful extras
vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Recent files' })
vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Find word under cursor' })
vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Find keymaps' })
vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = 'Find commands' })

-- My favorites for quick access
vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Find files' })
vim.keymap.set('n', '<C-f>', builtin.live_grep, { desc = 'Live grep' })
