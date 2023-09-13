return {
  {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = { 'jay-babu/mason-null-ls.nvim',
      'MunifTanjim/eslint.nvim',
    },
    config = function()
      local null_ls = require("null-ls")
      local mason_null_ls = require("mason-null-ls")
      local formatting = null_ls.builtins.formatting
      local diagonstics = null_ls.builtins.diagnostics
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      local eslint = require("eslint")
      mason_null_ls.setup({
        ensure_installed = {
          "prettier",
          -- "eslint_d",
          "stylua",
        },
      })

      null_ls.setup({
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
                vim.lsp.buf.format({ async = true })
              end,
            })
          end
        end,

        sources = {
          formatting.prettier,
          formatting.clang_format,
          -- formatting.prismaFmt,
          -- formatting.stylua,
          -- diagonstics.eslint_d,
        },
      })

      eslint.setup({
        bin = 'eslint', -- or `eslint_d`
        code_actions = {
          enable = true,
          apply_on_save = {
            enable = true,
            types = { "directive", "problem", "suggestion", "layout" },
          },
          disable_rule_comment = {
            enable = true,
            location = "separate_line", -- or `same_line`
          },
        },
        diagnostics = {
          enable = true,
          report_unused_disable_directives = false,
          run_on = "type", -- or `save`
        },
      })
    end
  },
}
