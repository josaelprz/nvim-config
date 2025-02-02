return {
  "neovim/nvim-lspconfig",
  keys = {},
  init = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    keys[#keys + 1] = { "<S-k>", mode = { "n" }, false }

    -- Setup for TailwindCSS
    require("lspconfig").tailwindcss.setup({
      settings = {
        tailwindCSS = {
          experimental = {
            classRegex = {
              { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
              { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
            },
          },
        },
      },
    })

    -- Bash Language Server Configuration
    require("lspconfig").bashls.setup({
      handlers = {
        ["textDocument/publishDiagnostics"] = function(err, res, ...)
          local file_name = vim.fn.fnamemodify(vim.uri_to_fname(res.uri), ":t")
          -- Skip diagnostics for .env files
          if string.match(file_name, "^%.env") == nil then
            -- Call the default diagnostic handler if it's not a .env file
            vim.lsp.diagnostic.on_publish_diagnostics(err, res, ...)
          end
        end,
      },
    })
  end,
  opts = {
    servers = {
      tsserver = {
        enabled = false,
      },
      vtsls = {
        settings = {
          complete_function_calls = true,
          vtsls = {
            enableMoveToFileCodeAction = true,
            autoUseWorkspaceTsdk = true,
            experimental = {
              completion = {
                enableServerSideFuzzyMatch = true,
              },
            },
          },
          typescript = {
            updateImportsOnFileMove = { enabled = "always" },
            suggest = {
              completeFunctionCalls = true,
            },
            inlayHints = {
              enumMemberValues = { enabled = true },
              functionLikeReturnTypes = { enabled = false },
              parameterNames = { enabled = false },
              parameterTypes = { enabled = false },
              propertyDeclarationTypes = { enabled = false },
              variableTypes = { enabled = false },
            },
          },
        },
      },
    },
  },
}
