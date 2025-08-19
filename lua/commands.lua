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


-- Claude Code
local Terminal = require("toggleterm.terminal").Terminal
local claude_code = Terminal:new({cmd = "claude", direction = "float", hidden = true})

function _claude_code_toggle()
    claude_code:toggle()
end

vim.keymap.set("n", "<leader>cc", _claude_code_toggle, {desc = "Open Claude Code", noremap = true, silent = true})
vim.keymap.set("t", "<leader>cc", _claude_code_toggle, {desc = "Open Claude Code", noremap = true, silent = true})


-- Claude Code with Resume
local claude_code_resume = Terminal:new({cmd = "claude -r", direction = "float", hidden = true})

function _claude_code_resume_toggle()
    claude_code_resume:toggle()
end

vim.keymap.set("n", "<leader>cr", _claude_code_resume_toggle, {desc = "Open Claude Code with Resume", noremap = true, silent = true})
vim.keymap.set("t", "<leader>cr", _claude_code_resume_toggle, {desc = "Open Claude Code with Resume", noremap = true, silent = true})
