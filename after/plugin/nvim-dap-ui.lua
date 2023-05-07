local dapui = require'dapui'
dapui.setup()

vim.keymap.set('n', '<Leader>du', dapui.toggle)
