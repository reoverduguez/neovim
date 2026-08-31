return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        terminal_colors = true,
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        inverse = true,
        contrast = "hard",
        transparent_mode = false,
      })
      vim.o.background = "dark"
      vim.cmd([[colorscheme gruvbox]])
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      require("lualine").setup({
        options = {
          theme = "gruvbox",
          component_separators = { left = "│", right = "│" },
          section_separators = { left = "", right = "" },
          globalstatus = true, -- keep a single, clean statusline across all splits
        },
        sections = {
          lualine_a = { { "mode", separator = { left = "", right = "" } } },
          lualine_b = { "branch", "diff" },
          lualine_c = { { "filename", file_status = true, path = 1 } },
          lualine_x = { "diagnostics", "filesize", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { { "location", separator = { left = "", right = "" } } },
        },
      })
    end,
  }
}
