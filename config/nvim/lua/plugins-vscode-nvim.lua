return require('lazy').setup({
  -- easymotion
  {
    'easymotion/vim-easymotion',
    init = function()
      vim.g.EasyMotion_do_mapping = 0
    end,
    keys = {
      { "s/", "<Plug>(easymotion-sn)", mode = { "n", "x" }, { noremap = false } },
    }
  },

  -- nerdcommenter
  {
    'scrooloose/nerdcommenter',
    lazy = true,
    keys = {
      { "sc", "<Plug>NERDCommenterToggle", mode = { "n", "v" }, { noremap = false } },
    }
  },

  {
    'kylechui/nvim-surround',
    lazy = false,
    opts = {},
  },

  -- treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    config = function(_, _)
      require('nvim-treesitter.configs').setup({
        ignore_install = {},
        auto_install = false,
        ensure_installed = { "lua" },
        sync_install = false,
        modules = {},
        highlight = {
          enable = true
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<F9>",
            node_incremental = "<F7>",
            scope_incremental = "+",
            node_decremental = "<F8>",
          },
        }
      });
    end
  },
});
