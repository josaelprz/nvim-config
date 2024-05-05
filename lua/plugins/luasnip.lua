return {
  "L3MON4D3/LuaSnip",
  config = function()
    -- Load snippets from JSON files (VSCode syntax)
    require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
  end,
}
