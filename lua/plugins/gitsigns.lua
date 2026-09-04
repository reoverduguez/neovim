return {
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      signs = {
        add = { text = '┃' },
        change = { text = '┃' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
      },
      on_attach = function(bufnr)
        local gitsigns = require('gitsigns')
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end
        map('n', ']h', function()
          if vim.wo.diff then
            vim.cmd.normal({ ']c', bang = true })
          else
            gitsigns.nav_hunk('next')
          end
        end, { desc = 'Go to next git change/hunk' })

        map('n', '[h', function()
          if vim.wo.diff then
            vim.cmd.normal({ '[c', bang = true })
          else
            gitsigns.nav_hunk('prev')
          end
        end, { desc = 'Go to previous git change/hunk' })

        map('n', '<leader>gs', gitsigns.stage_hunk, { desc = 'Stage active git change/hunk' })
        map('n', '<leader>gr', gitsigns.reset_hunk, { desc = 'Reset/Undo active git change' })

        map('v', '<leader>gs', function()
          gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, { desc = 'Stage highlighted block' })
        map('v', '<leader>gr', function()
          gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, { desc = 'Reset/Undo highlighted block' })

        map('n', '<leader>gS', gitsigns.stage_buffer, { desc = 'Stage entire file' })
        map('n', '<leader>gu', gitsigns.undo_stage_hunk, { desc = 'Undo last staged change' })
        map('n', '<leader>gp', gitsigns.preview_hunk, { desc = 'Preview change differences (diff)' })
        map('n', '<leader>gb', function()
          gitsigns.blame_line({ full = true })
        end, { desc = 'Show line git blame author details' })
        map('n', '<leader>gd', gitsigns.diffthis, { desc = 'Show side-by-side git diff view' })
      end,
    },
  },
}
