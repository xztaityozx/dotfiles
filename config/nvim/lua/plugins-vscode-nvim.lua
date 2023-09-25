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
    opts = {
      keymaps = {
        -- prefixを張替え
        normal = "tt", -- ys
        normal_cur = "th", -- yss
        normal_cur_line = "tg", --yS
        visual = "t", -- S
      },
    },
    keys = {
      -- tf に ysiwf を割り当て、関数名が要求される
      { "tf", "<Plug>(nvim-surround-normal)iwf", mode = { "n" }, { noremap = true, silent = true } },
    }
  },
  
  -- treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    config = function(_, _)
      require('nvim-treesitter.configs').setup({
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
