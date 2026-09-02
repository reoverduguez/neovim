return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>bn", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer (tab order)" },
      { "<leader>bp", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer (tab order)" },
      { "<leader>bd", "<cmd>bdelete<cr>", desc = "Delete active buffer" },
      { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Close all other buffers" },
      { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Close buffers to the right" },
      { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Close buffers to the left" },

      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Go to next tab/buffer" },
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Go to previous tab/buffer" },
    },
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          separator_style = "thin",
          always_show_bufferline = true,
          show_buffer_close_icons = false,
          show_close_icon = false,
          diagnostics = "nvim_lsp", -- Enable tracking of LSP diagnostics
          diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local s = " "
            for e, n in pairs(diagnostics_dict) do
              local sym = e == "error" and "  " or (e == "warning" and "  " or "  ")
              s = s .. n .. sym
            end
            return s
          end,
          -- Align the tabs with your Neo-tree file explorer sidebar
          offsets = {
            {
              filetype = "neo-tree",
              text = "File Explorer",
              text_align = "center",
              separator = true,
            },
          },
        },
      })
    end,
  },
}

