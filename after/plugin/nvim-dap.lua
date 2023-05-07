local dap = require('dap')
local map = vim.api.nvim_set_keymap
local options = { noremap = true, silent = true }

map('n', '<leader>db', '<cmd>lua require"dap".toggle_breakpoint()<CR>', options)
map('n', '<leader>dB', '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', options)
map('n', '<leader>dc', '<cmd>lua require"dap".continue()<CR>', options)
map('n', '<leader>dn', '<cmd>lua require"dap".step_over()<CR>', options)
map('n', '<leader>di', '<cmd>lua require"dap".step_into()<CR>', options)
map('n', '<leader>do', '<cmd>lua require"dap".step_out()<CR>', options)
map('n', '<leader>dr', '<cmd>lua require"dap".repl.toggle()<CR>', options)
map('n', '<leader>dl', '<cmd>lua require"dap".run_last()<CR>', options)
map('n', '<leader>de', '<cmd>lua require"dap".disconnect()<CR>', options)
map('n', '<leader>dp', '<cmd>lua require"dap".pause.toggle()<CR>', options)

require('dap-python').setup('python')

