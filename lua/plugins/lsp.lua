return {
  "neovim/nvim-lspconfig",
  keys = {},
  init = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    keys[#keys + 1] = { "<S-k>", mode = { "n" }, false }
  end,
}
