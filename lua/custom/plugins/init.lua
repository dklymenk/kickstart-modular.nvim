--  You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'numToStr/Comment.nvim',
    config = function()
      local prehook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
      require('Comment').setup {
        pre_hook = prehook,
        toggler = {
          line = '<leader>/',
        },
        opleader = {
          line = '<leader>/',
        },
      }
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
  },
  {
    'kelly-lin/ranger.nvim',
    config = function()
      require('ranger-nvim').setup { replace_netrw = true, ui = { height = 0.95 } }
      vim.api.nvim_set_keymap('n', '<leader>r', '', {
        noremap = true,
        callback = function()
          require('ranger-nvim').open(true)
        end,
      })
    end,
  },
  { 'ruanyl/vim-gh-line' },
  { 'chaoren/vim-wordmotion' },
  {
    'toppair/peek.nvim',
    event = { 'VeryLazy' },
    build = 'deno task --quiet build:fast',
    config = function()
      require('peek').setup()
      vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
      vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
    end,
  },
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        panel = {
          enabled = true,
          auto_refresh = false,
          keymap = {
            jump_prev = '[[',
            jump_next = ']]',
            accept = '<CR>',
            refresh = 'gr',
            open = '<M-CR>',
          },
          layout = {
            position = 'bottom', -- | top | left | right | horizontal | vertical
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          hide_during_completion = true,
          debounce = 75,
          keymap = {
            accept = '<C-y>',
            accept_word = false,
            accept_line = false,
            next = '<C-n>',
            prev = '<C-p>',
            dismiss = '<C-e>',
          },
        },
        filetypes = {
          yaml = false,
          markdown = false,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ['.'] = false,
        },
        logger = {
          file = vim.fn.stdpath 'log' .. '/copilot-lua.log',
          file_log_level = vim.log.levels.OFF,
          print_log_level = vim.log.levels.WARN,
          trace_lsp = 'off', -- "off" | "messages" | "verbose"
          trace_lsp_progress = false,
          log_lsp_messages = false,
        },
        copilot_node_command = 'node', -- Node.js version must be > 18.x
        workspace_folders = {},
        copilot_model = '', -- Current LSP default is gpt-35-turbo, supports gpt-4o-copilot
        root_dir = function()
          return vim.fs.dirname(vim.fs.find('.git', { upward = true })[1])
        end,
        server_opts_overrides = {},
      }
    end,
  },
  {
    'olimorris/codecompanion.nvim',
    opts = {},
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'j-hui/fidget.nvim',
    },
    init = function()
      require('custom.plugins.codecompanion.fidget-spinner'):init()
      vim.cmd [[cab cc CodeCompanion]]
      vim.keymap.set({ 'n', 'v' }, '<leader>aa', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true })
      vim.keymap.set({ 'n', 'v' }, '<LocalLeader>at', '<cmd>CodeCompanionChat Toggle<cr>', { noremap = true, silent = true })
      vim.keymap.set('v', 'ga', '<cmd>CodeCompanionChat Add<cr>', { noremap = true, silent = true })
    end,
  },
}
