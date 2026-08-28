return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle File Explorer sidebar" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        window = {
          width = 30, -- default sidebar width
        },
        filesystem = {
          filtered_items = {
            visible = true, -- Show hidden files by default
          },
          follow_current_file = {
            enabled = true, -- Automatically syncs the tree focus to the active buffer
          },
        },
      })
    end,
  },
}
