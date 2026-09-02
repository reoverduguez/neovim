-- OPTIONS
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.sidescrolloff = 10
vim.opt.sidescrolloff = 10
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.fileformats = "unix"
vim.opt.smartindent = false
vim.opt.autoindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.signcolumn = "yes:1"
vim.opt.showmatch = true
vim.opt.cmdheight = 1
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.showmode = false
vim.opt.pumheight = 10
vim.opt.pumblend = 10
vim.opt.winblend = 0
vim.opt.conceallevel = 0
vim.opt.concealcursor = ""
vim.opt.lazyredraw = true
vim.opt.fillchars = { eob = " " }

local undodir = vim.fn.expand("~/.vim/undodir")
if
  vim.fn.isdirectory(undodir) == 0
then
  vim.fn.mkdir(undodir, "p")
end

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = undodir
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 0
vim.opt.autoread = true
vim.opt.autowrite = false
vim.opt.hidden = true
vim.opt.errorbells = false
vim.opt.backspace = "indent,eol,start"
vim.opt.autochdir = false
vim.opt.iskeyword:append("-")
vim.opt.path:append("**")
vim.opt.selection = "inclusive"
vim.opt.encoding = "UTF-8"
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.diffopt:append("linematch:60")
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000
vim.opt.spell = true
vim.opt.spelllang = { "en_us" }

-- Disable automatic commenting on new lines
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- Diagnostic & Gruvbox Highlighting Configuration

-- General Diagnostic Behavior (Icons & Popups)
local signs = { Error = "■", Warn = "▲", Info = "◆", Hint = "●" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  virtual_text = {
    severity = { min = vim.diagnostic.severity.WARN },
    prefix = function(diagnostic)
      local icons = {
        [vim.diagnostic.severity.ERROR] = "●",
        [vim.diagnostic.severity.WARN]  = "▲",
        [vim.diagnostic.severity.INFO]  = "◆",
        [vim.diagnostic.severity.HINT]  = "●",
      }
      return icons[diagnostic.severity] or "●"
    end,
    spacing = 4,
  },
  signs = {
    text = {
      -- gutter icons
      [vim.diagnostic.severity.ERROR] = "●",
      [vim.diagnostic.severity.WARN]  = "▲",
      [vim.diagnostic.severity.INFO]  = "◆",
      [vim.diagnostic.severity.HINT]  = "●",
    }
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
    prefix = " ",
  },
})

-- Highlight Overrides (Protected inside a ColorScheme Autocommand)
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    local colors = {
      bright_red    = "#fb4934",
      bright_orange = "#fe8019",
      bright_blue   = "#83a598",
      bright_aqua   = "#8ec07c",
      bg0_h         = "#1d2021",
    }

    -- Apply bright Gruvbox undercurls
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = colors.bright_red, bold = true })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = colors.bright_orange, bold = true })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = colors.bright_blue })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = colors.bright_aqua })

    -- Apply matching colors to virtual text
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = colors.bright_red, bold = true })
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = colors.bright_orange })

    -- Apply matching colors to sidebar signs
    vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = colors.bright_red, bold = true })
    vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = colors.bright_orange, bold = true })
    vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = colors.bright_blue })
    vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = colors.bright_aqua })

    -- High-contrast popup window styling
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = colors.bg0_h })
    vim.api.nvim_set_hl(0, "FloatBorder", { fg = colors.bright_orange, bg = colors.bg0_h })
  end,
})

