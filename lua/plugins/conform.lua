return {
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' }, -- Loads when you run the info command
    keys = {
      {
        '<leader>cf',
        function()
          require('conform').format({
            async = true,
            lsp_fallback = false,
            timeout_ms = 1000,
          })
        end,
        mode = { 'n', 'v' },
        desc = 'Format file (Normal) or Selection (Visual)',
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'eslint_d', 'prettier' },
        typescript = { 'eslint_d', 'prettier' },
        javascriptreact = { 'eslint_d', 'prettier' },
        typescriptreact = { 'eslint_d', 'prettier' },
      },
      formaters = {
        eslint_d = {
          condition = function(self, ctx)
            return vim.fs.find({
              'eslint.config.js',
              'eslint.config.mjs',
              'eslint.config.cjs',
              '.eslintrc',
              '.eslintrc.js',
              '.eslintrc.json',
              '.eslintrc.yaml',
              '.eslintrc.yml',
            }, { path = ctx.filename, upward = true })[1] ~= nil
          end,
        },
        prettier = {
          condition = function(self, ctx)
            return vim.fs.find({
              '.prettierrc',
              '.prettierrc.json',
              '.prettierrc.yml',
              '.prettierrc.yaml',
              '.prettierrc.json5',
              '.prettierrc.js',
              '.prettierrc.cjs',
              '.prettierrc.mjs',
              'prettier.config.js',
              'prettier.config.cjs',
              'prettier.config.mjs',
            }, { path = ctx.filename, upward = true })[1] ~= nil
          end,
        },
      },
    },
  },
}
