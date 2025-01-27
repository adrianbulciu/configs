local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').reset()
require('packer').init({
  compile_path = vim.fn.stdpath('data')..'/site/plugin/packer_compiled.lua',
})

local use = require('packer').use

-- Packer can manage itself.
use('wbthomason/packer.nvim')


-- One Dark theme.
use({
  -- 'navarasu/onedark.nvim',
  'jessarcher/onedark.nvim',
  config = function()
    -- require('onedark').setup {
    --   style = 'darker'
    -- }
    -- require('onedark').load()
    vim.cmd('colorscheme onedark')

   vim.api.nvim_set_hl(0, 'FloatBorder', {
     fg = vim.api.nvim_get_hl_by_name('NormalFloat', true).background,
     bg = vim.api.nvim_get_hl_by_name('NormalFloat', true).background,
   })

   -- Make the cursor line background invisible
   -- vim.api.nvim_set_hl(0, 'CursorLineBg', {
   --   fg = vim.api.nvim_get_hl_by_name('CursorLine', true).background,
   --   bg = vim.api.nvim_get_hl_by_name('CursorLine', true).background,
   -- })

   vim.api.nvim_set_hl(0, 'NvimTreeIndentMarker', { fg = '#30323E' })

   vim.api.nvim_set_hl(0, 'StatusLineNonText', {
     fg = vim.api.nvim_get_hl_by_name('NonText', true).foreground,
     bg = vim.api.nvim_get_hl_by_name('StatusLine', true).background,
   })

   vim.api.nvim_set_hl(0, 'IndentBlanklineChar', { fg = '#2F313C' })

   vim.api.nvim_set_hl(0, 'LineNrAbove', { fg='#51B3EC'})
   vim.api.nvim_set_hl(0, 'LineNr', { fg='white'})
   vim.api.nvim_set_hl(0, 'LineNrBelow', { fg='#FB508F'})

   -- vim.api.nvim_set_hl(0, 'MatchParen', {underline = false, fg = 'black', bg = 'white'})
  end,
})

-- Commenting support.
use('tpope/vim-commentary')

-- Add, change, and delete surrounding text.
use('tpope/vim-surround')

-- Useful commands like :Rename and :SudoWrite.
--use('tpope/vim-eunuch')

-- Pairs of handy bracket mappings, like [b and ]b.
use('tpope/vim-unimpaired')

-- Indent autodetection with editorconfig support.
use('tpope/vim-sleuth')

-- Allow plugins to enable repeating of commands.
use('tpope/vim-repeat')

-- Add more languages.
use('sheerun/vim-polyglot')

-- Navigate seamlessly between Vim windows and Tmux panes.
--use('christoomey/vim-tmux-navigator')

-- Jump to the last location when opening a file.
--use('farmergreg/vim-lastplace')

-- Enable * searching with visually selected text.
use('nelstrom/vim-visual-star-search')

use('jessarcher/vim-heritage')

-- Text objects for HTML attributes.
--use({
--  'whatyouhide/vim-textobj-xmlattr',
--  requires = 'kana/vim-textobj-user',
--})

-- Automatically set the working directory to the project root.
--use({
--  'airblade/vim-rooter',
--  setup = function()
--    -- Instead of this running every time we open a file, we'll just run it once when Vim starts.
--    vim.g.rooter_manual_only = 1
--  end,
--  config = function()
--    vim.cmd('Rooter')
--  end,
--})

-- Automatically add closing brackets, quotes, etc.
use({
  'windwp/nvim-autopairs',
  config = function()
    require('nvim-autopairs').setup()
  end,
})

-- Add smooth scrolling to avoid jarring jumps
use({
  'karb94/neoscroll.nvim',
  config = function()
    require('neoscroll').setup()
  end,
})

-- All closing buffers without closing the split window.
use({
  'famiu/bufdelete.nvim',
  config = function()
    vim.keymap.set('n', '<Leader>q', ':bdelete<CR>')
  end,
})

-- Split arrays and methods onto multiple lines, or join them back up.
use({
  'AndrewRadev/splitjoin.vim',
  config = function()
    vim.g.splitjoin_html_attributes_bracket_on_new_line = 1
    vim.g.splitjoin_trailing_comma = 1
    vim.g.splitjoin_php_method_chain_full = 1
  end,
})

-- Automatically fix indentation when pasting code.
use({
  'sickill/vim-pasta',
  config = function()
    vim.g.pasta_disabled_filetypes = { 'fugitive' }
  end,
})

-- Fuzzy finder
use({
  'nvim-telescope/telescope.nvim',
  requires = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-live-grep-args.nvim',
    'kyazdani42/nvim-web-devicons',
    { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
  },
  config = function()
    require('user/plugins/telescope')
  end,
})

-- File tree sidebar
use({
  'kyazdani42/nvim-tree.lua',
  requires = 'kyazdani42/nvim-web-devicons',
  config = function()
    require('user/plugins/nvim-tree')
  end,
})

-- A Status line.
use({
  'nvim-lualine/lualine.nvim',
  requires = 'kyazdani42/nvim-web-devicons',
  config = function()
    require('user/plugins/lualine')
  end,
})

-- Display buffers as tabs.
use({
  'akinsho/bufferline.nvim',
  after = 'onedark.nvim',
  config = function()
    require('user/plugins/bufferline')
  end,
})

-- Display indentation lines.
use({
  'lukas-reineke/indent-blankline.nvim',
  config = function()
    require('user/plugins/indent-blankline')
  end,
})

-- Git integration.
use({
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup()
    -- vim.keymap.set('n', ']h', ':Gitsigns next_hunk<CR>')
    -- vim.keymap.set('n', '[h', ':Gitsigns prev_hunk<CR>')
    -- vim.keymap.set('n', 'gs', ':Gitsigns stage_hunk<CR>')
    -- vim.keymap.set('n', 'gS', ':Gitsigns undo_stage_hunk<CR>')
    -- vim.keymap.set('n', 'gp', ':Gitsigns preview_hunk<CR>')
    -- vim.keymap.set('n', 'gb', ':Gitsigns blame_line<CR>')
  end,
})
-- Floating terminal.
--use({
--  'voldikss/vim-floaterm',
--  config = function()
--    vim.g.floaterm_width = 0.8
--    vim.g.floaterm_height = 0.8
--    vim.keymap.set('n', '<F1>', ':FloatermToggle<CR>')
--    vim.keymap.set('t', '<F1>', '<C-\\><C-n>:FloatermToggle<CR>')
--    vim.cmd([[
--      highlight link Floaterm CursorLine
--      highlight link FloatermBorder CursorLineBg
--    ]])
--  end
--})
--
---- Improved syntax highlighting
use({
  'nvim-treesitter/nvim-treesitter',
  run = function()
    require('nvim-treesitter.install').update({ with_sync = true })
  end,
  requires = {
    'JoosepAlviste/nvim-ts-context-commentstring',
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = function()
    require('user/plugins/treesitter')
  end,
})

-- Language Server Protocol.
use({
  'neovim/nvim-lspconfig',
  requires = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'b0o/schemastore.nvim',
    'jose-elias-alvarez/null-ls.nvim',
    'jayp0521/mason-null-ls.nvim',
  },
  config = function()
    require('user/plugins/lspconfig')
  end,
})

-- Completion
use({
  'hrsh7th/nvim-cmp',
  requires = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'onsails/lspkind-nvim',
  },
  config = function()
    require('user/plugins/cmp')
  end,
})

use({
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require'treesitter-context'.setup{
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        multiwindow = false, -- Enable multiwindow support.
        max_lines = 10, -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to show for a single context
        trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20, -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
      }

      vim.api.nvim_set_hl(0, 'TreesitterContext', { bg='#242529'})
      vim.api.nvim_set_hl(0, 'TreesitterContextLineNumber', { fg='#FFCC00'})
    end,
})

---- PHP Refactoring Tools
--use({
--  'phpactor/phpactor',
--  ft = 'php',
--  run = 'composer install --no-dev --optimize-autoloader',
--  config = function()
--    vim.keymap.set('n', '<Leader>pm', ':PhpactorContextMenu<CR>')
--    vim.keymap.set('n', '<Leader>pn', ':PhpactorClassNew<CR>')
--  end,
--})
--
---- Project Configuration.
--use({
--  'tpope/vim-projectionist',
--  requires = 'tpope/vim-dispatch',
--  config = function()
--    require('user/plugins/projectionist')
--  end,
--})
--
---- Testing helper
--use({
--  'vim-test/vim-test',
--  config = function()
--    require('user/plugins/vim-test')
--  end,
--})

-- Automatically set up your configuration after cloning packer.nvim
-- Put this at the end after all plugins
if packer_bootstrap then
    require('packer').sync()
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile>
  augroup end
]])
