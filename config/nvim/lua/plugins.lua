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
    keys = {}
  },

  -- bufdelete
  {
    'famiu/bufdelete.nvim',
    lazy = true,
    keys = {
      { "bd", "<CMD>Bdelete<CR>", mode = { "n" }, { noremap = true, silent = true } },
    }
  },

  -- カッコとかの自動補完
  {
    'windwp/nvim-autopairs',
    config = true,
    lazy = true,
    event = "InsertEnter"
  },

  -- Git関係
  -- {{{
  -- Gitのマーク出してくれる君
  { 'airblade/vim-gitgutter' },

  -- lazygit
  {
    'kdheepak/lazygit.nvim',
    lazy = true,
    keys = {
      { "lg", "<CMD>LazyGit<CR>", mode = { "n" }, { noremap = true, silent = true } },
    }
  },
  -- カーソル行にBlame出してくれる君
  { 'f-person/git-blame.nvim' },
  {
    -- Diffを見やすく表示してくれる君
    'sindrets/diffview.nvim',
    lazy = true,
    cmd = {
      "DiffViewOpen",
    },
    dependencies = 'nvim-lua/plenary.nvim'
  },
  -- }}},

  -- ウインドウサイズ変更するやつ
  {
    'simeji/winresizer',
    init = function()
      -- Aで左に
      vim.g.winresizer_keycode_left = 97
      -- Wで上に
      vim.g.winresizer_keycode_up = 119
      -- Sで下に
      vim.g.winresizer_keycode_down = 115
      -- Dで右に
      vim.g.winresizer_keycode_right = 100
    end,
    lazy = true,
    keys = {
      { "<C-E>", mode = "n" }
    }
  },


  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      'neovim/nvim-lspconfig',

      "b0o/schemastore.nvim",
      'nvim-lua/lsp-status.nvim',
      'folke/lsp-colors.nvim',
      'folke/neodev.nvim',
    },
    lazy = false,
    init = function(_)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf;
          local opts = { noremap = true, silent = true };
          vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'i', '<C-Space>', '<cmd>lua vim.lsp.buf.completion()<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', 'sq', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.format({async = true})<CR>', opts)
          vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
          vim.keymap.set({ "v", "n" }, 'sA', require('actions-preview').code_actions, opts)

          vim.api.nvim_create_user_command("RenameSymbol",
            function()
              vim.lsp.buf.rename()
            end, {})
        end
      })
    end,
    config = function(_, _)
      require('mason').setup();
      require('mason-lspconfig').setup({
        ensure_installed = {
          "lua_ls"
        }
      });

      local lspconfig = require('lspconfig');

      require('mason-lspconfig').setup_handlers({
        function(server)
          local pwd = os.getenv("PWD");
          local basic_option = {
            capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
            settings = {
              Lua = {
                runtime = {
                  version = "LuaJIT",
                  path = (function()
                    local runtime_path = vim.split(package.path, ";", {});
                    table.insert(runtime_path, "lua/?.lua");
                    table.insert(runtime_path, "lua/*/init.lua");
                    return runtime_path;
                  end)(),
                },
                diagnostics = {
                  globals = { "vim" },
                },
                workspace = {
                  library = vim.api.nvim_get_runtime_file("", true),
                  checkThirdParty = false
                },
                telemetry = {
                  enable = false,
                },
              },
              perlnavigator = {
                perlPath = 'perl',
                enableWarnings = true,
                perlcriticEnabled = true,
                includePaths = { pwd .. '/lib', pwd .. '/local/lib/perl5', pwd .. '/.libt' },
              },
              yaml = {
                schemaStore = {
                  enable = false,
                  url = "",
                },
                schemas = require('schemastore').yaml.schemas(),
              },
            }
          };

          if server == "omnisharp" then
            basic_option.cmd = { "omnisharp" };
          end

          if server == "perlnavigator" then
            basic_option.cmd = { "perlnavigator", "--stdio" };
          end

          lspconfig[server].setup(basic_option);
        end
      });
    end
  },

  {
    "nvim-tree/nvim-web-devicons",
    opts = {
      color_icons = true
    },
    lazy = false,
  },

  {
    'folke/trouble.nvim',
    opts = {
      icons = true,
      fold_open = '',
      fold_closed = '',
      signs = {
        error = '',
        warning = '',
        hint = '',
        information = '',
        other = '',
      },
      use_diagnostic_signs = false,
      auto_open = false,
      auto_close = true,
    },
    keys = {
      { "s[", "<cmd>TroubleToggle<CR>", mode = "n", { silent = true, noremap = true } },
    },
    lazy = true,
    event = "LspAttach"
  },

  -- 補完
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      { 'neovim/nvim-lspconfig' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-cmdline' },
      { 'L3MON4D3/LuaSnip' },
      { 'saadparwaiz1/cmp_luasnip' },
    },
    lazy = true,
    event = "InsertEnter",
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        view = {
          entries = "custom"
        },
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
        window = {
          documentation = cmp.config.window.bordered(),
        },
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
          },
          {
            { name = 'buffer' },
            { name = 'path' },
          })
      })
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          { name = 'cmdline' },
        })
      })
    end
  },

  -- シグネチャヒント
  {
    "ray-x/lsp_signature.nvim",
    opts = {
      bind = true,
      handler_opts = {
        border = "rounded"
      },
      floating_window = true,
      toggle_key = '<C-l>',
      hint_prefix = '',
    },
    lazy = true,
    event = "LspAttach"
  },

  -- ステータスライン
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {},
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
          lualine_a = { 'mode' },
          lualine_b = {
            'branch',
            'diff',
          },
          lualine_c = { 'filetype', 'filename' },
          lualine_x = { "require('lsp-status').status()" },
          lualine_y = { 'encoding',
            { 'fileformat', symbols = { unix = ' Linux', dos = ' Windows', mac = ' macOS' } } },
          lualine_z = { 'location', custom_progress },
        },
        tabline = {},
        options = {
          theme = {
            normal = {
              a = { fg = colors.fg.black, bg = colors.indicator.normal },
              b = { fg = colors.fg.black, bg = colors.bg.b },
              c = { fg = colors.fg.white, bg = colors.bg.c },
              z = { fg = colors.fg.black, bg = colors.bg.z },
            },
            insert = {
              a = { fg = colors.fg.black, bg = colors.indicator.insert },
              b = { fg = colors.fg.black, bg = colors.bg.b },
              c = { fg = colors.fg.white, bg = colors.bg.c },
              z = { fg = colors.fg.black, bg = colors.bg.z },
            },
            visual = {
              a = { fg = colors.fg.black, bg = colors.indicator.visual },
              b = { fg = colors.fg.black, bg = colors.bg.b },
              c = { fg = colors.fg.white, bg = colors.bg.c },
              z = { fg = colors.fg.black, bg = colors.bg.z },
            },
            replace = {
              a = { fg = colors.fg.black, bg = colors.indicator.replace },
              b = { fg = colors.fg.black, bg = colors.bg.b },
              c = { fg = colors.fg.white, bg = colors.bg.c },
              z = { fg = colors.fg.black, bg = colors.bg.z },
            },
            inacive = {
              a = { fg = colors.fg.black, bg = '#33374c' },
              b = { fg = colors.fg.black, bg = '#262a3f' },
              c = { fg = colors.fg.white, bg = '#1e2132' },
            },
          },
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
        },
      })
    end
  },

  -- カーソル下にある単語と同じ奴にアンダーラインがつくやつ
  { 'itchyny/vim-cursorword' },

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
  -- インデントのガイドラインを表示するくん
  {
    "lukas-reineke/indent-blankline.nvim",
    cmd = {
      "IndentBlanklineToggle",
      "IndentBlanklineRefresh"
    },
    opts = {
      show_current_context = true,
      show_current_context_start = true
    }
  },

  -- terminal系
  {
    'akinsho/toggleterm.nvim',
    config = true,
    opts = {
      open_mapping = [[<F3>]],
      direction = 'horizontal',
    },
    lazy = true,
    keys = {
      { "<F3>", mode = { "i", "n" } }
    }
  },

  -- colorscheme
  { 'cocopon/iceberg.vim',   lazy = false, priority = 1000 },

  -- fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      -- ソート改善
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      -- LSPがあるとき、telescopeでアウトラインをピックできるやつ
      { 'stevearc/aerial.nvim',                     config = true },
      -- undo picker
      { 'debugloop/telescope-undo.nvim' },
    },
    config = function()
      require('telescope').setup({
        defaults = {
          sorting_strategy = 'ascending',
          layout_strategy = 'horizontal',
          layout_config = { prompt_position = "top" },
          mappings = {
            i = {
              ["<esc>"] = require('telescope.actions').close,
            },
          },
        },
        pickers = {
          find_files = {
            find_command = { 'fd', '--type', 'f', '--strip-cwd-prefix', '--hidden' }
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = 'smart_case',
          },
        },
      })

      require('telescope').load_extension('fzf')
      require('telescope').load_extension('aerial')
      require('telescope').load_extension('undo')
    end,
    keys = {
      { "<C-p>", "<cmd>Telescope find_files<CR>",  mode = "n", { noremap = true, silent = true } },
      { "sb",    "<cmd>Telescope buffers<CR>",     mode = "n", { noremap = true, silent = true } },
      { "sg",    "<cmd>Telescope live_grep<CR>",   mode = "n", { noremap = true, silent = true } },
      { "sh",    "<cmd>Telescope help_tags<CR>",   mode = "n", { noremap = true, silent = true } },
      { "sx",    "<cmd>Telescope grep_string<CR>", mode = "n", { noremap = true, silent = true } },
      { "sm",    "<cmd>Telescope oldfiles<CR>",    mode = "n", { noremap = true, silent = true } },
      { "s\"",   "<cmd>Telescope registers<CR>",   mode = "n", { noremap = true, silent = true } },
      { "sQ",    "<cmd>Telescope quickfix<CR>",    mode = "n", { noremap = true, silent = true } },
      { "sf",    "<cmd>Telescope aerial<CR>",      mode = "n", { noremap = true, silent = true } },
      { "su",    "<cmd>Telescope undo<CR>",        mode = "n", { noremap = true, silent = true } },
    }
  },
  { 'nvim-treesitter/nvim-treesitter-context' },
  {
    -- LSPでコードアクションがある時に電球マーク出してくれるやつ
    'kosayoda/nvim-lightbulb',
    opts = {
      autocmd = { enabled = true },
      virtual_text = { enabled = false },
    },
    lazy = true,
    event = "LspAttach"
  },

  {
    -- コードアクションのDiffをTelescopeでみられるやつ
    "aznhe21/actions-preview.nvim",
    opts = {
      -- バックエンドに使うプラグインの優先順位。デフォルトではtelescopeを優先的に使う
      backend = { "nui", "telescope" },
      -- telescopeで表示する場合の設定。ウィンドウ小さめでもいい感じに出す
      telescope = {
        sorting_strategy = "ascending",
        layout_strategy = "vertical",
        layout_config = {
          width = 0.8,
          height = 0.9,
          prompt_position = "top",
          preview_cutoff = 20,
          preview_height = function(_, _, max_lines)
            return max_lines - 15
          end,
        },
      },
    },
    lazy = true,
    event = "LspAttach"
  },

  -- copilot
  {
    'github/copilot.vim',
    config = function()
      vim.api.nvim_set_keymap('i', '<C-J>', 'copilot#Accept("\\<CR>")', { expr = true, script = true, silent = true })
      vim.g.copilot_no_tab_map = false
    end,
    lazy = false
  }
});
