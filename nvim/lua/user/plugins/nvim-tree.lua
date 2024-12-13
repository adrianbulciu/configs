require('nvim-tree').setup({
  git = {
    ignore = false,
  },
  renderer = {
    icons = {
      -- show = {
      --   folder_arrow = false,
      -- },
    },
    indent_markers = {
      enable = true,
    },
  },
})

vim.keymap.set('n', '<Leader>n', ':NvimTreeFindFileToggle<CR>')
