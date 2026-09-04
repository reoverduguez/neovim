return {
  {
    'echasnovski/mini.nvim',
    version = false, -- Pull the latest code
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('mini.pairs').setup()
      require('mini.surround').setup({
        mappings = {
          add = 'sa', -- Add surrounding
          delete = 'sd', -- Delete surrounding
          replace = 'sr', -- Replace surrounding
          find = 'sf', -- Find surrounding
          highlight = 'sh', -- Highlight surrounding
          update_n = 'sn', -- Update surrounding limit
        },
      })
      require('mini.indentscope').setup({
        symbol = '|',
        draw = {
          delay = 100,
          animation = nil,
        },
      })
      require('mini.align').setup()
      require('mini.bufremove').setup()
      require('mini.ai').setup()
      require('mini.trailspace').setup()
    end,
    keys = {
      {
        '<leader>bd',
        function()
          local bd = require('mini.bufremove').delete
          if vim.bo.modified then
            local choice = vim.fn.confirm(('Save changes to %q?'):format(vim.fn.expand('%:t')), '&Yes\n&No\n&Cancel')
            if choice == 1 then
              vim.cmd.write()
              bd(0)
            elseif choice == 2 then
              bd(0, true)
            end
          else
            bd(0)
          end
        end,
        desc = 'Delete buffer (layout-safe)',
      },
      {
        '<leader>cw',
        function()
          require('mini.trailspace').trim()
          vim.notify('All trailing whitespace cleaned!', vim.log.levels.INFO, { title = 'mini.trailspace' })
        end,
        desc = 'Clean trailing whitespace',
      },
    },
  },
}
