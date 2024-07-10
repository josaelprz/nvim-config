return {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    { "tpope/vim-dadbod", lazy = true },
    { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
  },
  init = function()
    vim.g.db_ui_use_nvim_notify = true
    vim.g.db_ui_use_nerd_fonts = true
  end,
}
