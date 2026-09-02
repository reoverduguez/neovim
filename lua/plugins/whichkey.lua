return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy", -- Load instantly on startup
    config = function()
      local whichkey = require("which-key")
      whichkey.setup({
        preset = "helix",
        win = {
          no_overlap = true,  -- Don't cover typing cursor
          width = 0.5,
          border = "rounded",
          padding = { 1, 2 },
          wo = {
            winblend = 20,    -- 10% frosted glass transparency
          },
        },
      })
      whichkey.add({
        { "<leader>b", group = "Buffers" },
        { "<leader>c", group = "Code / LSP", mode = { "n", "v" } },
        { "<leader>f", group = "Find / Telescope" },
        { "<leader>r", group = "Refactoring" },
        { "<leader>s", group = "Window Split" },
        { "<leader>g", group = "Git", mode = { "n", "v" } },
      })
    end,
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Search all buffer-local keymaps",
      },
    },
  },
}

