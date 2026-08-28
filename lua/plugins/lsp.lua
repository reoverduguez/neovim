return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- Mason: Manages the downloads of LSPs, formatters, and compilers
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      -- Fidget: Adds status spinners in the bottom-right corner
      { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
      local lspconfig = require("lspconfig")
      require("mason-lspconfig").setup({
        -- Automatically download these servers on startup!
        ensure_installed = {
          "lua_ls",
          "ts_ls",
          "jsonls",
          "bashls",
          "yamlls",
        },
        handlers = {
          function(server_name)
            lspconfig[server_name].setup({})
          end,
          ["lua_ls"] = function()
            lspconfig.lua_ls.setup({
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { "vim" },
                  },
                  workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                  },
                  telemetry = { enable = false },
                },
              },
            })
          end,
        },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to code definition", buffer = ev.buf })
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to code declaration", buffer = ev.buf })
          vim.keymap.set("n", "gr",
          function()
            require("telescope.builtin").lsp_references({
                layout_strategy = "vertical",
                layout_config = {
                  width = 0.9,
                  height = 0.8,
                  preview_height = 0.6,
                },
            })
          end, { desc = "Show references", buffer = ev.buf })
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Show implementations", buffer = ev.buf })
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show hover documentation details", buffer = ev.buf })
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "List available code action/fixes", buffer = ev.buf })
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename variable or function across codebase", buffer = ev.buf })
          vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show line diagnostics", buffer = ev.buf })
        end,
      })
    end,
  },
}

