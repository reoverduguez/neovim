return {
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>cf',
        function()
          require('conform').format({
            async = false,
            lsp_fallback = false,
            timeout_ms = 3000,
          })
        end,
        mode = 'n',
        desc = 'Format file',
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
      },
    },
  },
}
