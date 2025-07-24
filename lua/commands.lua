-- Create the OpenConfig command
vim.api.nvim_create_user_command('ConfigOpen', function()
  -- Get the config directory path
  local config_path = vim.fn.stdpath('config')
  
  -- Open the config directory in netrw file explorer
  vim.cmd('edit ' .. config_path)
end, {
  desc = 'Open Neovim configuration directory'
})

-- LazyGit
local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({cmd = "lazygit", direction = "float", hidden = true})

function _lazygit_toggle()
    lazygit:toggle()
end

vim.keymap.set("n", "<leader>gg", _lazygit_toggle, {desc = "Open LazyGit", noremap = true, silent = true})

