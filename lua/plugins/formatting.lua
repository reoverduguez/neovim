return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" }, -- Loads when you run the info command
    keys = {
      {
        "<leader>mp", -- "Format Project"
        function()
          require("conform").format({ async = true, lsp_fallback = false })
        end,
        mode = "",
        desc = "Format active file or visual selection",
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "eslint_d", "prettier" },
        typescript = { "eslint_d", "prettier" },
        javascriptreact = { "eslint_d", "prettier" },
        typescriptreact = { "eslint_d", "prettier" },
      },
      formaters = {
        eslint_d = {
          condition = function(self, ctx)
            return vim.fs.find({
              "eslint.config.js",
              "eslint.config.mjs",
              "eslint.config.cjs",
              ".eslintrc",
              ".eslintrc.js",
              ".eslintrc.json",
              ".eslintrc.yaml",
              ".eslintrc.yml",
            }, { path = ctx.filename, upward = true })[1] ~= nil
          end,
        },
        prettier = {
          condition = function(self, ctx)
            return vim.fs.find({
              ".prettierrc",
              ".prettierrc.json",
              ".prettierrc.yml",
              ".prettierrc.yaml",
              ".prettierrc.json5",
              ".prettierrc.js",
              ".prettierrc.cjs",
              ".prettierrc.mjs",
              "prettier.config.js",
              "prettier.config.cjs",
              "prettier.config.mjs",
            }, { path = ctx.filename, upward = true })[1] ~= nil
          end,
        },
      },
      format_on_save = {
        timeout_ms = 1000,   -- Wait up to 1 second for ESLint to finish auto-fixing
        lsp_fallback = false, -- Turn off LSP fallback so it strictly uses local configs
      },
    },
  },
}

