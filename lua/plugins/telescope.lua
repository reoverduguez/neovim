return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope", -- Lazy load when the command is called
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Fuzzy find files" },
      {
        "<leader>fg",
        function()
          require("telescope.builtin").live_grep({
            layout_strategy = "vertical",
            layout_config = {
              width = 0.9,
              height = 0.8,
              preview_height = 0.6,
              preview_cutoff = 0
            },
          })
        end,
        desc = "Search text inside files (required ripgrep in OS)",
      },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "List open buffers/tabs" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Search Neovim help documentation" },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Search and check all keymaps (Great for conflicts!)" },
    },
    config = function()
      local telescope = require("telescope")

      telescope.setup({
        defaults = {
          -- Ignore bulky, non-source directories
          file_ignore_patterns = { "node_modules", ".git/", "dist/", "build/" },

          layout_strategy = "horizontal",
          layout_config = {
            prompt_position = "top", -- Set prompt at the top
          },
          sorting_strategy = "ascending", -- Search results sort from top to bottom
        },
      })

      telescope.load_extension("fzf")
    end,
  },
}

