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

-- Format file
map("n", "<Leader>fo", vim.lsp.buf.format)

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

local builtin = require("telescope.builtin")

-- Search by word
map("n", "<leader>sw", builtin.grep_string)

-- Search in multiple files with grep
map("n", "<Leader>sg", builtin.live_grep)

-- Search files
map("n", "<Leader>sf", builtin.find_files)

-- Search open files
map("n", "<Leader>so", builtin.buffers)

-- Search diagnostics
map("n", "<leader>sd", builtin.diagnostics)

-- Search keymaps
map("n", "<leader>sk", builtin.keymaps)

-- Search help
map("n", "<leader>sh", builtin.help_tags)

-- Find & Replace

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    local builtin = require("telescope.builtin")
    local opts = { buffer = event.buf }

    -- Show options about the word under your cursor
    map("n", "<Leader>o", vim.lsp.buf.hover, opts)

    -- Code action
    map("n", "<Leader>.", vim.lsp.buf.code_action, opts)

    -- Rename symbol under your cursor
    map("n", "<Leader>rs", vim.lsp.buf.rename, opts)

    -- Go to definition of the word under your cursor
    -- map("n", "<Leader>gd", vim.lsp.buf.definition, opts)
    map("n", "<Leader>gd", builtin.lsp_definitions, opts)

    -- Go to type definition of the word under your cursor.
    -- map('n', '<Leader>gt', vim.lsp.buf.type_definition, opts)
    map("n", "<Leader>gt", builtin.lsp_type_definitions, opts)

    -- Go to declaration of the word under your cursor
    -- Useful when language allow forward declarations
    map("n", "<Leader>gD", vim.lsp.buf.declaration, opts)

    -- Go to implementation of the word under your cursor
    -- map("n", "<Leader>gi", vim.lsp.buf.implementation, opts)
    map("n", "<Leader>gi", builtin.lsp_implementations, opts)

    -- Find references for the word under your cursor.
    map("n", "<Leader>gr", builtin.lsp_references, opts)

    -- Fuzzy find all the symbols in your current document.
    map("n", "<Leader>ss", builtin.lsp_document_symbols, opts)

    -- Fuzzy find all the symbols in your current workspace.
    map("n", "<Leader>sS", builtin.lsp_dynamic_workspace_symbols, opts)

    -- The following two autocommands are used to highlight references of the word under your cursor
    -- when your cursor rests there for a little while. When you move your cursor, the highlights will be cleared
    -- See :help CursorHold for information about when this is executed
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if client and client.server_capabilities.documentHighlightProvider then
      local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })

      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})

vim.api.nvim_create_autocmd("LspDetach", {
  group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
  callback = function(event)
    vim.lsp.buf.clear_references()
    vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event.buf })
  end,
})

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

-- NOTE: LSP COMPLETIONS
local cmp = require("cmp")
map({ "n", "i" }, "<A-j>", cmp.select_next_item)
map({ "n", "i" }, "<A-k>", cmp.select_prev_item)
map({ "n", "i" }, "<C-Space>", cmp.complete)
