require('josiah.packer')
require('josiah.lsp_settings')

vim.o.number = true
vim.o.relativenumber = true
vim.cmd('set nohlsearch')

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.softtabstop = 4

vim.o.scrolloff = 5

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
