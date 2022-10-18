vim.cmd [[packadd packer.nvim]]
local use = require("packer").use;

return require('packer').startup({function()
  -- packer.nvim を packer.nvimで管理しちゃう
  use 'wbthomason/packer.nvim'

  -- easymotion
  use {
    'easymotion/vim-easymotion',
    setup = function()
      vim.g.EasyMotion_do_mapping = 0
      vim.api.nvim_set_keymap('n', 's/', '<Plug>(easymotion-sn)', {noremap = false})
      vim.api.nvim_set_keymap('x', 's/', '<Plug>(easymotion-sn)', {noremap = false})
    end,
  }

  -- nerdcommenter
  use {
    'scrooloose/nerdcommenter',
    setup = function()
      vim.api.nvim_set_keymap('n', 'sc', '<Plug>NERDCommenterToggle', {noremap = false})
      vim.api.nvim_set_keymap('v', 'sc', '<Plug>NERDCommenterToggle', {noremap = false})
    end,
  }

  -- vim-surround
  use 'tpope/vim-surround'

  -- bufdelete
  use {
    'famiu/bufdelete.nvim',
    setup = function()
      vim.api.nvim_set_keymap('n', 'bd', '<CMD>Bdelete<CR>', {noremap = true, silent = true})
    end,
  }

  -- カッコとかの自動補完
  --use 'cohama/lexima.vim'
  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup({})
    end
  }


  -- Go言語向けの設定
  -- {{{
  use {
    'mattn/vim-goimports',
    run = 'go install golang.org/x/tools/cmd/goimports@latest'
  }
  -- }}}

  -- Git関係
  -- {{{
  use 'airblade/vim-gitgutter'
  -- lazygit
  use {
    'kdheepak/lazygit.nvim',
    config = function()
      --vim.g.lazygit_floating_window_use_plenary = 1
      vim.api.nvim_set_keymap('n', 'lg', '<CMD>LazyGit<CR>', {noremap = true, silent = true})
    end
  }
  -- }}}

  -- ウインドウサイズ変更するやつ
  use {
    'simeji/winresizer',
    setup = function()
      -- Aで左に
      vim.g.winresizer_keycode_left=97
      -- Wで上に
      vim.g.winresizer_keycode_up=119
      -- Sで下に
      vim.g.winresizer_keycode_down=115
      -- Dで右に
      vim.g.winresizer_keycode_right=100
    end
  }

  -- lspの設定
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  }

  require('mason').setup();
  require('mason-lspconfig').setup_handlers({function(server) 
    local opt = {
      capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
      on_attach = function(client, bufnr)
        local opts = { noremap=true, silent=true }
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-<space>>', '<cmd>lua vim.lsp.buf.completion()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-R><C-R>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'sq', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
      end
    };
    require('lspconfig')[server].setup(opt)
  end})

  use {
    'neovim/nvim-lspconfig',
    requires = {
      {'nvim-lua/lsp-status.nvim'},
      {'folke/lsp-colors.nvim'},
      {'folke/neodev.nvim'},
    },
  }

  local runtime_path = vim.split(package.path, ";");
  table.insert(runtime_path, "lua/?.lua")
  table.insert(runtime_path, "lua/*/init.lua")
  require('lspconfig').sumneko_lua.setup{
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
          path = runtime_path,
        },
        diagnostics = {
          globals = {"vim"},
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = {
          enable = false,
        },
      }
    }
  }
  require('lspconfig').perlnavigator.setup{}

  use {
    'folke/trouble.nvim',
    config = function()
    end
  }
  require('trouble').setup({})

  -- 補完
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      {'neovim/nvim-lspconfig'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'hrsh7th/cmp-cmdline'},
      {'L3MON4D3/LuaSnip'},
      {'saadparwaiz1/cmp_luasnip'}
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end
        },
        -- キーマッピングここから
        mapping = {
          -- Enterで候補決定。選択されてなかったら無視して改行
          ['<CR>'] = function(fallback)
            if cmp.visible() and cmp.get_selected_entry() then
              cmp.confirm()
            else
              fallback()
            end
          end,
          -- Shift+Tabで一つ上を選択
          ['<S-TAB>'] = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end,
          -- Tabで一つ下を選択
          ['<TAB>'] = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end
        },
        sources = cmp.config.sources({
          {name = 'nvim_lsp'},
          {name = 'luasnip'}
        },
          {
            {name = 'buffer'},
            {name = 'path'},
          })
      })
    end
  }

  -- ステータスライン
  use {
    'nvim-lualine/lualine.nvim',
    requires = {
      {'kyazdani42/nvim-web-devicons', opt = true},
      {'kdheepak/tabline.nvim', config = function() require('tabline').setup({enable = false})end},
    },
    config = function()
      local function custom_progress()
        return [[%3p%% %3l/%3L]]
      end

      local colors = {
        indicator = {
          normal = '#c57339',
          insert = '#3f83a6',
          visual = '#6845ad',
          replace = '#cc3768',
        },
        fg = {
          black = '#1e2132',
          white = '#8389a3',
        },
        bg = {
          b = '#818596',
          c = '#262a3f',
          z = '#e9b189',
        },
      }

      require('lualine').setup({
        sections = {
          lualine_a = {'mode'},
          lualine_b = {
            'branch',
            'diff',
          },
          lualine_c = {'filetype','filename'},
          lualine_x = {"require('lsp-status').status()"},
          lualine_y = {'encoding', {'fileformat', symbols = { unix = ' Linux', dos = ' Windows', mac = ' macOS' }}},
          lualine_z = {'location',custom_progress},
        },
        tabline = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { require'tabline'.tabline_buffers },
          lualine_y = {},
          lualine_z = {'tabs'},
        },
        options = {
          theme = {
            normal = {
              a = {fg = colors.fg.black, bg = colors.indicator.normal},
              b = {fg = colors.fg.black, bg = colors.bg.b},
              c = {fg = colors.fg.white, bg = colors.bg.c},
              z = {fg = colors.fg.black, bg = colors.bg.z},
            },
            insert = {
              a = {fg = colors.fg.black, bg = colors.indicator.insert},
              b = {fg = colors.fg.black, bg = colors.bg.b},
              c = {fg = colors.fg.white, bg = colors.bg.c},
              z = {fg = colors.fg.black, bg = colors.bg.z},
            },
            visual = {
              a = {fg = colors.fg.black, bg = colors.indicator.visual},
              b = {fg = colors.fg.black, bg = colors.bg.b},
              c = {fg = colors.fg.white, bg = colors.bg.c},
              z = {fg = colors.fg.black, bg = colors.bg.z},
            },
            replace = {
              a = {fg = colors.fg.black, bg = colors.indicator.replace},
              b = {fg = colors.fg.black, bg = colors.bg.b},
              c = {fg = colors.fg.white, bg = colors.bg.c},
              z = {fg = colors.fg.black, bg = colors.bg.z},
            },
            inacive = {
              a = {fg = colors.fg.black, bg = '#33374c'},
              b = {fg = colors.fg.black, bg = '#262a3f'},
              c = {fg = colors.fg.white, bg = '#1e2132'},
            },
          },
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
        }
      })
    end
  }

  -- VimDevIcons
  use 'ryanoasis/vim-devicons'

  -- カーソル下にある単語と同じ奴にアンダーラインがつくやつ
  use 'itchyny/vim-cursorword'

  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ":TSUpdate",
    config = function()
      require('nvim-treesitter.configs').setup({
        indent = {
          enable = true,
        },
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
          }
        }
      })
    end
  }

  -- terminal系
  use {
    'akinsho/toggleterm.nvim',
    config = function ()
      require('toggleterm').setup({
        direction = 'float',
        open_mapping = [[<F3>]]
      })
    end
  }

  -- colorscheme
  use {'cocopon/iceberg.vim', opt = true}

  -- fuzzy finder
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/plenary.nvim'},
      use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    },
    config = function()
      vim.api.nvim_set_keymap('n', '<C-p>', "<cmd>Telescope find_files<CR>", {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', 'sb',    "<cmd>Telescope buffers<CR>", {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', 'sg',    "<cmd>Telescope live_grep<CR>", {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', 'sh',    "<cmd>Telescope help_tags<CR>", {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', 'sx',    "<cmd>Telescope grep_string<CR>", {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', 'sm',    "<cmd>Telescope oldfiles<CR>", {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', 's"',    "<cmd>Telescope registers<CR>", {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', 'sQ',    "<cmd>Telescope quickfix<CR>", {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', 'sf',    "<cmd>Telescope treesitter<CR>", {noremap = true, silent = true})

      -- lsp系
      vim.api.nvim_set_keymap('n', 'sA',    "<cmd>Telescope lsp_code_actions<CR>", {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', 'gd',    "<cmd>Telescope lsp_definitions<CR>", {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', 'gT',    "<cmd>Telescope lsp_type_definitions<CR>", {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', 'sD',    "<cmd>Telescope diagnostics<CR>", {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', 'gr',    "<cmd>Telescope lsp_references<CR>", {noremap = true, silent = true})

      require('telescope').setup({
        defaults = {
          sorting_strategy = 'ascending',
          layout_strategy = 'horizontal',
          layout_config = { prompt_position = "top" },
          mappings = {
            i = {
              ["<esc>"] = require('telescope.actions').close,
            }
          }
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = 'smart_case',
          }
        }
      })

      require('telescope').load_extension('fzf')
    end
  }
  use 'nvim-treesitter/nvim-treesitter-context'

end, config = {
    display = {
      open_fn = require('packer.util').float,
    }
  }});

