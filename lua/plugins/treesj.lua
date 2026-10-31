return {
  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    keys = {
      { '<leader>ct', '<cmd>TSJToggle<cr>', desc = 'Toggle Split/Join Code Block' },
    },
    opts = {
      use_default_keymaps = false, -- Disabling default keymaps to use the custom lazy-loaded ones above
      max_join_length = 400, -- Adjust the max line length allowed for a join
    },
  },
}
