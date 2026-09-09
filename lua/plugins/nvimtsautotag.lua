return {
  {
    'windwp/nvim-ts-autotag',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('nvim-ts-autotag').setup({
        opts = {
          -- Defaults
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = false, -- Auto close on trailing </
        },
      })
    end,
  },
}
