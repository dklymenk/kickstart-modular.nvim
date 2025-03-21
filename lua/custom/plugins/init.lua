-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'numToStr/Comment.nvim',
    opts = {
      toggler = {
        line = '<leader>/',
      },
      opleader = {
        line = '<leader>/',
      },
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
}
