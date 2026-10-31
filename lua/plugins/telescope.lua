return {
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope', -- Lazy load when the command is called
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
      },
      'nvim-telescope/telescope-live-grep-args.nvim',
    },
    keys = {
      {
        '<leader>ff',
        '<cmd>Telescope find_files<cr>',
        desc = 'Find files',
      },
      {
        --[[
          common ripgrep flags:
          - Filetype limit:    "pattern" -t js
          - Exclude folder:    "pattern" --iglob !**/tests/**
          - Whole word only:   "pattern" -w
          - Case sensitive:    "pattern" -s
          - Ignore gitignore:  "pattern" --no-ignore
        ]]
        --
        '<leader>fg',
        function()
          require('telescope').extensions.live_grep_args.live_grep_args({
            layout_strategy = 'vertical',
            layout_config = {
              width = 0.9,
              height = 0.8,
              preview_height = 0.6,
              preview_cutoff = 0,
            },
          })
        end,
        desc = 'Search text inside files',
      },
      {
        '<leader>fb',
        '<cmd>Telescope buffers<cr>',
        desc = 'List open buffers/tabs',
      },
      {
        '<leader>fh',
        '<cmd>Telescope help_tags<cr>',
        desc = 'Search Neovim help documentation',
      },
      {
        '<leader>fk',
        '<cmd>Telescope keymaps<cr>',
        desc = 'Search and check all keymaps (Great for conflicts!)',
      },
    },
    config = function()
      local telescope = require('telescope')
      local action_state = require('telescope.actions.state')
      local actions = require('telescope.actions')
      local lga_actions = require('telescope-live-grep-args.actions')
      local scroll_results_right = function(prompt_bufnr)
        local picker = action_state.get_current_picker(prompt_bufnr)
        local results_win = picker.results_win
        vim.api.nvim_win_call(results_win, function()
          vim.cmd('normal! 15zl') -- shifts horizontal viewport 15 columns right
        end)
      end
      local scroll_results_left = function(prompt_bufnr)
        local picker = action_state.get_current_picker(prompt_bufnr)
        local results_win = picker.results_win
        vim.api.nvim_win_call(results_win, function()
          vim.cmd('normal! 15zh') -- shifts horizontal viewport 15 columns left
        end)
      end

      telescope.setup({
        defaults = {
          -- Ignore bulky, non-source directories
          file_ignore_patterns = { 'node_modules', '.git/', 'dist/', 'build/' },
          path_display = { 'filename_first' },
          layout_strategy = 'horizontal',
          layout_config = {
            prompt_position = 'top', -- Set prompt at the top
          },
          sorting_strategy = 'ascending', -- Search results sort from top to bottom
          preview = {
            filesize_limit = 0.1, -- MB
            timeout = 250,
          },
          mappings = {
            i = {
              ['<Right>'] = scroll_results_right,
              ['<Left>'] = scroll_results_left,
            },
            n = {
              ['<Right>'] = scroll_results_right,
              ['<Left>'] = scroll_results_left,
            },
          },
        },
        pickers = {
          find_files = {
            theme = 'dropdown',
            previewer = false,
            hidden = true,
          },
          buffers = {
            theme = 'dropdown',
            previewer = false,
            sort_mru = true,
            sort_lastused = true,
            mappings = {
              i = {
                ['<C-d>'] = actions.delete_buffer,
              },
              n = {
                ['dd'] = actions.delete_buffer,
              },
            },
            extensions = {
              live_grep_args = {
                auto_quoting = true,
                mappings = {
                  i = {
                    ['<C-i'] = lga_actions.quote_prompt({
                      postfix = ' --iglob ',
                    }),
                  },
                },
              },
            },
          },
        },
      })
      telescope.load_extension('fzf')
      telescope.load_extension('live_grep_args')
    end,
  },
}
