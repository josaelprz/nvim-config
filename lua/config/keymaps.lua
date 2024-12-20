-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- NOTE: GLOBAL

-- Set leader key
-- See :help mapleader

vim.g.mapleader = " "
-- vim.g.maplocalleader = " "

-- Set escape
map("i", "jj", "<Esc>")

-- NOTE: WINDOW: NAVIGATION

-- Split editor vertically
map("n", "<Leader>v", ":vsplit<CR>")
-- Split editor horizontally
map("n", "<Leader>b", ":split<CR>")

-- Switch Panes
map("n", "<C-h>", ":wincmd h<CR>", { noremap = true })
map("n", "<C-l>", ":wincmd l<CR>")
map("n", "<C-j>", ":wincmd j<CR>")
map("n", "<C-k>", ":wincmd k<CR>")

-- NOTE: EDITOR: NAVIGATION

-- Up
-- Defaults to 'k'
-- Down
-- Defaults to 'j'
-- Left
-- Defaults to 'h'
-- Right
-- Defaults to 'l'

-- Start of line
map("n", "gh", "^")
map("v", "gh", "^")

-- End of line
map("n", "gl", "$")
map("v", "gl", "$")

-- Page up
map("n", "gk", "22k")
map("v", "gk", "22k")

-- Page down
map("n", "gj", "22j")
map("v", "gj", "22j")

-- Next word
map("n", "<S-l>", "w")
map("v", "<S-l>", "w")

-- Previous word
map("n", "<S-h>", "b")
map("v", "<S-h>", "b")

-- Move line up
map("n", "<S-k>", "ddkP")

-- Move line down
map("n", "<S-j>", "ddp")

-- Add line up
map("n", "<S-o>", "<S-o><Esc>")

-- Add line down
map("n", "o", "o<Esc>")

-- Select all
map("n", "vaa", "ggVG")

-- NOTE: EDITOR: FORMATTING

local conform = require("conform")

-- Format file
map("n", "<Leader>fo", conform.format)

-- Indent
map("n", ".", ">>")
map("v", ".", ">gv")

-- Outdent
map("n", ",", "<<")
map("v", ",", "<gv")

-- NOTE: EDITOR: COPY & PASTE

-- Paste (the yanked text no longer changes on select and paste)
map("v", "p", "P")

-- NOTE: FILES

-- Save file
map("n", "<Leader>w", ":w!<CR>")

-- Quit file or close panel
map("n", "<Leader>q", ":q<CR>")

-- Undo
-- Defaults to 'u'

-- Redo
map("n", "U", "<C-r>")

-- NOTE: SEARCHING & REFACTORING

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Set highlight on search, but clear on pressing <Esc> in normal mode
-- Enter search mode with '*' on normal mode
vim.opt.hlsearch = true
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

local fzf = require("fzf-lua")

-- Search in multiple files with grep
map("n", "<Leader>sg", fzf.live_grep)

-- Search files
map("n", "<Leader>sf", fzf.files)

-- Search help
map("n", "<leader>sh", fzf.help_tags)

-- Find & Replace

-- Show options about the word under your cursor
map("n", "<Leader>o", vim.lsp.buf.hover)

-- Code action
map("n", "<Leader>.", vim.lsp.buf.code_action)

-- Rename symbol under your cursor
map("n", "<Leader>rs", vim.lsp.buf.rename)

-- Go to definition of the word under your cursor
map("n", "<Leader>gd", vim.lsp.buf.definition)

-- Go to type definition of the word under your cursor.
map("n", "<Leader>gt", vim.lsp.buf.type_definition)

-- Go to implementation of the word under your cursor
map("n", "<Leader>gi", vim.lsp.buf.implementation)

-- NOTE: EXPLORER
local explorer = require("oil")

-- Open
map("n", "<leader>eo", explorer.open)
-- Close
map("n", "<leader>ec", explorer.close)
-- Save
map("n", "<leader>es", explorer.save)
-- Toggle hidden
map("n", "<leader>et", explorer.toggle_hidden)

-- NOTE: OUTLINE
map("n", "<leader>ol", "<cmd>topleft Outline<CR>")

-- NOTE: TEST
local test = require("neotest")

map("n", "<leader>tr", test.run.run)
map("n", "<leader>ts", test.run.stop)
map("n", "<leader>to", test.summary.toggle)
map("n", "<leader>tm", test.output_panel.toggle)
map("n", "<leader>tc", test.output_panel.clear)
