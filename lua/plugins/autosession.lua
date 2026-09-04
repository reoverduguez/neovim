return {
  {
    'rmagatti/auto-session',
    lazy = false, -- Must be false so it runs immediately on startup to restore your files!
    opts = {
      enabled = true,
      auto_save = true, -- Automatically save the session when exiting Neovim
      auto_restore = true, -- Automatically restore your session when opening Neovim
      auto_create = true, -- Automatically create new session files as you work
      suppressed_dirs = { '~/', '~/Downloads', '/' }, -- Do NOT save/restore sessions in these generic folders
      pre_save_cmds = {
        'Neotree close',
      },
      post_restore_cmds = {
        'silent! bufdo edit', -- Force a safe refresh of all tabs to start Treesitter
      },
    },
  },
}
