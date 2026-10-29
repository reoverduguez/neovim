return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      {
        'mason-org/mason.nvim',
        opts = {
          ui = {
            icons = {
              package_installed = '✓',
              package_pending = '➜',
              package_uninstalled = '✗',
            },
          },
        },
      },
      'mason-org/mason-lspconfig.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
      local lsp_servers = {
        'angularls',
        'emmet_language_server',
        'eslint',
        'html',
        'lua_ls',
        'ts_ls',
        'jsonls',
        'bashls',
        'yamlls',
      }

      local mason_servers = {
        'angularls@19.2.4',
        'emmet_language_server',
        'eslint',
        'html',
        'lua_ls',
        'ts_ls',
        'jsonls',
        'bashls',
        'yamlls',
      }

      vim.filetype.add({
        pattern = {
          ['.*%.component%.html'] = 'htmlangular',
        },
      })
      -- Highlight htmlangular buffers using html tree-sitter parser
      vim.treesitter.language.register('html', 'htmlangular')

      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file('', true),
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })

      vim.lsp.config('html', {
        filetypes = {
          'html',
        },
      })

      vim.lsp.config('angularls', {
        filetypes = {
          'typescript',
          'htmlangular',
        },
        root_markers = {
          'angular.json',
          'nx.json',
        },
      })

      vim.lsp.config('eslint', {
        filetypes = {
          'javascript',
          'javascriptreact',
          'typescript',
          'typescriptreact',
          'htmlangular',
        },
      })

      require('mason-lspconfig').setup({
        ensure_installed = mason_servers,
        automatic_enable = false,
      })

      for _, server in ipairs(lsp_servers) do
        vim.lsp.enable(server)
      end

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {
          clear = true,
        }),
        callback = function(ev)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to code definition', buffer = ev.buf })
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to code declaration', buffer = ev.buf })
          vim.keymap.set('n', 'gr', function()
            require('telescope.builtin').lsp_references({
              layout_strategy = 'vertical',
              layout_config = {
                width = 0.9,
                height = 0.8,
                preview_height = 0.6,
                preview_cutoff = 0,
              },
            })
          end, { desc = 'Show references', buffer = ev.buf })
          vim.keymap.set('n', 'gi', function()
            local supports_implementation = false
            for _, client in ipairs(vim.lsp.get_clients({ bufnr = ev.buf })) do
              if client:supports_method('textDocument/implementation', ev.buf) then
                supports_implementation = true
                break
              end
            end
            if supports_implementation then
              vim.lsp.buf.implementation()
            else
              vim.lsp.buf.definition()
            end
          end, { desc = 'Show implementation', buffer = ev.buf })

          vim.keymap.set(
            'n',
            'K',
            vim.lsp.buf.hover,
            { desc = 'Show hover documentation details', buffer = ev.buf }
          )
          vim.keymap.set(
            'n',
            '<leader>cr',
            vim.lsp.buf.rename,
            { desc = 'Rename variable or function across codebase', buffer = ev.buf }
          )
          vim.keymap.set(
            'n',
            '<leader>d',
            vim.diagnostic.open_float,
            { desc = 'Show line diagnostics', buffer = ev.buf }
          )

          vim.keymap.set('n', '<leader>D', function()
            require('telescope.builtin').diagnostics({
              bufnr = 0,
              layout_strategy = 'vertical',
              layout_config = {
                width = 0.9,
                height = 0.9,
                preview_height = 0.6,
                preview_cutoff = 0,
              },
            })
          end, { desc = 'Show document diagnostics', buffer = ev.buf })

          vim.keymap.set('n', 'gS', function()
            require('telescope.builtin').lsp_document_symbols({
              layout_strategy = 'vertical',
              layout_config = {
                width = 0.9,
                height = 0.8,
                preview_height = 0.6,
                preview_cutoff = 0,
              },
            })
          end, { desc = 'Show document code hierarchy/symbols', buffer = ev.buf })

          vim.keymap.set('n', '<leader>ci', function()
            require('telescope.builtin').lsp_incoming_calls({
              layout_strategy = 'vertical',
              layout_config = {
                width = 0.9,
                height = 0.8,
                preview_height = 0.6,
                preview_cutoff = 0,
              },
            })
          end, { desc = 'Show incoming call hierarchy', buffer = ev.buf })

          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {
            desc = 'List available code actions/fixes',
            buffer = ev.buf,
          })

          vim.keymap.set('n', '<leader>cm', function()
            vim.lsp.buf.code_action({
              apply = true,
              filter = function(action)
                return action.title == 'Add all missing imports'
              end,
            })
          end, { desc = 'Add missing imports', buffer = ev.buf })
        end,
      })
    end,
  },
}
