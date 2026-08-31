return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter", -- Loads only when you enter Insert Mode!
    dependencies = {
      -- Sources: Tells nvim-cmp where to fetch suggestions from
      "hrsh7th/cmp-nvim-lsp", -- Fetch from active LSPs (Pyright, ts_ls, etc.)
      "hrsh7th/cmp-buffer",   -- Fetch from text inside your current file
      "hrsh7th/cmp-path",     -- Fetch from file system paths
      -- Snippet Engine: Required for expanding code snippets (like loops)
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")

      local ok, luasnip = pcall(require, "luasnip")
      if not ok then
        return
      end

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4), -- Scroll down
          ["<C-f>"] = cmp.mapping.scroll_docs(4), -- Scroll up
          ["<C-Space>"] = cmp.mapping.complete(), -- Force open completion menu
          ["<C-e>"] = cmp.mapping.abort(),        -- Close/Abort completion menu
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm suggestion with Enter
          -- Cycle through suggestions: (Tab moves down list, Shift-Tab moves up) 
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        -- Fetch suggestions from, in order of priority
        sources = cmp.config.sources({
          { name = "nvim_lsp" }, -- 1. High priority: Active LSPs
          { name = "luasnip" },  -- 2. Code Snippets
          { name = "path" },     -- 3. File system paths
          { name = "buffer" },   -- 4. Text words inside active file
        }),
      })
    end,
  },
}
