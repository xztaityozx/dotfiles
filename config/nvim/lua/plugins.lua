return {
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

  -- split と join をやってくれるやつ
  {
    'Wansmer/treesj',
    lazy = true,
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter' },
    },
    ops = {
      use_default_keymaps = false,
    },
    keys = {
      { "sj", "<CMD>lua require('treesj').toggle()<CR>", mode = { "n", "v" }, { noremap = true, silent = true } },
    }
  },

  {
    'kylechui/nvim-surround',
    lazy = false,
    opts = {},
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
  -- Gitのマーク出してくれる君
  { 'airblade/vim-gitgutter' },

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
    "mason-org/mason.nvim",
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
      'neovim/nvim-lspconfig',

      "b0o/schemastore.nvim",
      'nvim-lua/lsp-status.nvim',
      'folke/lsp-colors.nvim',
      'folke/neodev.nvim',
      {
        "ray-x/lsp_signature.nvim",
        opts = {
          bind = true,
          handler_opts = {
            border = "single"
          },
          floating_window = true,
          hint_prefix = '',
          toggle_key_flip_floatwin_setting = true,
        },
        lazy = true,
        event = "LspAttach",
        keys = {
          { "<C-k>", "<cmd>lua require('lsp_signature').toggle_float_win()<CR>", mode = { "n", "i" }, { silent = true, noremap = true } },
        }
      }
    },
    lazy = false,
    init = function(_)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf;
          local opts = { noremap = true, silent = true };
          vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'i', '<C-Space>', '<cmd>lua vim.lsp.buf.completion()<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.format({async = true})<CR>', opts)
          vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
          vim.keymap.set({ "v", "n" }, '<M-.>', require('actions-preview').code_actions, opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        end
      })
    end,
    config = function(_, _)
      require('mason').setup();
      require('mason-lspconfig').setup({
        automatic_enable = true
      });

      vim.lsp.config('*', {
        capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
      });

      vim.lsp.config('lua_ls', {
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
          }
        }
      });

      vim.lsp.config('perlnavigator', {
        settings = {
          perlnavigator = {
            perlPath = 'perl',
            enableWarnings = true,
            perlcriticEnabled = true,
          }
        }
      });

      vim.lsp.config('yaml', {
        settings = {
          yaml = {
            schemaStore = {
              enable = false,
              url = "",
            },
            schemas = require('schemastore').yaml.schemas(),
          }
        }
      });

      vim.lsp.config('pylsp', {
        settings = {
          pylsp = {
            plugins = {
              ruff = {
                enabled = true
              },
              pycodestyle = {
                enabled = false,
              }
            }
          }
        }
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
    opts = {},
    cmd = "Trouble",
    keys = {
      { "s[", "<cmd>Trouble diagnostics toggle<CR>", mode = "n", { silent = true, noremap = true } },
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

  -- ステータスライン
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      { 'kdheepak/tabline.nvim',      opts = { enable = false } },
      { 'arkav/lualine-lsp-progress', event = "LspAttach" },
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
          lualine_a = { 'mode' },
          lualine_b = {
            'branch',
            'diff',
          },
          lualine_c = { 'filetype', 'filename' },
          lualine_x = { "lsp_progress", { "lsp_status", ignore_lsp = {} } },
          lualine_y = { 'encoding',
            { 'fileformat', symbols = { unix = ' Linux', dos = ' Windows', mac = ' macOS' } } },
          lualine_z = { 'location', custom_progress },
        },
        tabline = {
          lualine_c = { require('tabline').tabline_buffers },
          lualine_z = { 'tabs' }
        },
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
        extensions = {
          'nvim-tree',
        }
      })
    end
  },

  -- カーソル下にある単語と同じ奴にアンダーラインがつくやつ
  { 'itchyny/vim-cursorword' },

  -- treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    config = function(_, _)
      vim.wo.foldmethod = "expr"
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.wo.foldlevel = 99
      require('nvim-treesitter.configs').setup({
        modules = {},
        sync_install = false,
        ensure_installed = { "lua" },
        auto_install = false,
        ignore_install = {},
        highlight = {
          enable = true
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<F9>",
            node_incremental = "[",
            scope_incremental = "+",
            node_decremental = "]",
          },
        }
      });
    end
  },
  -- インデントのガイドラインを表示するくん
  {
    "lukas-reineke/indent-blankline.nvim",
    lazy = false,
    opts = {},
    main = "ibl",
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
    cmd = {
      'Telescope'
    },
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      -- ソート改善
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      -- LSPがあるとき、telescopeでアウトラインをピックできるやつ
      { 'stevearc/aerial.nvim',                     config = true },
      -- undo picker
      { 'debugloop/telescope-undo.nvim' },
      { "nvim-telescope/telescope-ui-select.nvim" }
    },
    config = function()
      local telescope = require('telescope')
      telescope.setup({
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
            find_command = {
              'fd',
              ".",
              '--type', 'f',
              '--strip-cwd-prefix',
              '--hidden',
              "--exclude='*.png'",
              "--exclude='*.jpg'",
              "--exclude=.git/"
            }
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

      telescope.load_extension('fzf')
      telescope.load_extension('aerial')
      telescope.load_extension('undo')
      telescope.load_extension('ui-select')
    end,
    keys = {
      { "<C-p>", "<cmd>Telescope find_files<CR>",  mode = "n", { noremap = true, silent = true } },
      { "sb",    "<cmd>Telescope buffers<CR>",     mode = "n", { noremap = true, silent = true } },
      { "sg",    "<cmd>Telescope live_grep<CR>",   mode = "n", { noremap = true, silent = true } },
      { "sh",    "<cmd>Telescope help_tags<CR>",   mode = "n", { noremap = true, silent = true } },
      { "sx",    "<cmd>Telescope grep_string<CR>", mode = "n", { noremap = true, silent = true } },
      { "sm",    "<cmd>Telescope oldfiles<CR>",    mode = "n", { noremap = true, silent = true } },
      { "s2",    "<cmd>Telescope registers<CR>",   mode = "n", { noremap = true, silent = true } },
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

  -- 数値のインクリメントとかをいい感じにやってくれるやつ
  {
    'monaqa/dial.nvim',
    lazy = true,
    config = false,
    keys = {
      { [[<C-a>]],  function() require('dial.map').manipulate("increment", "normal") end,  mode = { "n" }, { noremap = true, silent = true } },
      { [[<C-x>]],  function() require('dial.map').manipulate("decrement", "normal") end,  mode = { "n" }, { noremap = true, silent = true } },
      { [[<C-a>]],  function() require('dial.map').manipulate("increment", "visual") end,  mode = { "v" }, { noremap = true, silent = true } },
      { [[<C-x>]],  function() require('dial.map').manipulate("decrement", "visual") end,  mode = { "v" }, { noremap = true, silent = true } },
      { [[g<C-a>]], function() require('dial.map').manipulate("increment", "gvisual") end, mode = { "v" }, { noremap = true, silent = true } },
      { [[g<C-x>]], function() require('dial.map').manipulate("decrement", "gvisual") end, mode = { "v" }, { noremap = true, silent = true } },
    }
  },

  {
    'folke/which-key.nvim',
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {}
  },

  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = true,
    keys = {
      { [[<F6>]],  "<CMD>NvimTreeToggle<CR>", mode = { "n", "i" }, { noremap = true, silent = true } },
      { [[<C-l>]], "<CMD>NvimTreeFocus<CR>",  mode = { "n", "i" }, { noremap = true, silent = true } },
    },
    opts = {
      view = {
        side = "left",
      },
      on_attach = function(bufnr)
        local nvim_tree_api = require("nvim-tree.api")
        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        vim.keymap.set("n", "<2-LeftMouse>", nvim_tree_api.node.open.edit, opts("Open"))
        vim.keymap.set("n", "<C-h>", nvim_tree_api.node.open.horizontal, opts("Open: Horizontal Split"))
        vim.keymap.set("n", "<C-v>", nvim_tree_api.node.open.vertical, opts("Open: Vertical Split"))
        vim.keymap.set("n", "<CR>", nvim_tree_api.node.open.edit, opts("Open"))
        vim.keymap.set("n", "R", nvim_tree_api.tree.reload, opts("Refresh"))
        vim.keymap.set("n", "a", nvim_tree_api.fs.create, opts("Create File Or Directory"))
        vim.keymap.set("n", "d", nvim_tree_api.fs.remove, opts("Delete"))
        vim.keymap.set("n", "e", nvim_tree_api.fs.rename_basename, opts("Rename: Basename"))
        vim.keymap.set("n", "q", nvim_tree_api.tree.close, opts("Close"))
        vim.keymap.set("n", "r", nvim_tree_api.fs.rename, opts("Rename"))
        vim.keymap.set("n", "yy", nvim_tree_api.fs.copy.filename, opts("Copy Name"))
      end
    }
  },

  -- debugger
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
      { "theHamsta/nvim-dap-virtual-text", opts = {} },
    },
    lazy = true,
    config = function()
      local dap = require('dap')
      dap.adapters.perl = {
        type = 'executable',
        command = vim.env.MASON .. '/bin/perl-debug-adapter',
        args = {},
        options = {
          initialize_timeout_sec = 20,
        },
        cwd = "${workspaceFolder}",
      }
      dap.configurations.perl = {
        {
          type = 'perl',
          request = 'launch',
          name = 'Launch Perl',
          program = '${workspaceFolder}/${relativeFile}',
        },
        {
          type = 'perl',
          request = 'launch',
          name = 'Launch Prove',
          program = '${workspaceFolder}/bin/debuggable-prove.pl',
          args = { '${workspaceFolder}/t' },
        }
      }

      dap.set_log_level('TRACE')
      local dapui = require('dapui')
      dapui.setup()
    end,
    cmd = {
      "DapToggleBreakpoint",
    },
    keys = {
      { "s<F4>", "<CMD>lua require('dapui').toggle()<CR>",          mode = { "n" }, { noremap = true, silent = true } },
      { "<F8>",  "<CMD>lua require('dap').toggle_breakpoint()<CR>", mode = { "n" }, { noremap = true, silent = true } },
      { "<F7>",  "<CMD>lua require('dap').step_over()<CR>",         mode = { "n" }, { noremap = true, silent = true } },
      { "s<F6>", "<CMD>lua require('dap').step_into()<CR>",         mode = { "n" }, { noremap = true, silent = true } },
      { "s<F3>", "<CMD>lua require('dap').continue()<CR>",          mode = { "n" }, { noremap = true, silent = true } },
      { "siK",   "<CMD>lua require('dap.ui.widgets').hover()<CR>",  mode = { "n" }, { noremap = true, silent = true } },
    }
  },

  -- copilot
  {
    'github/copilot.vim',
    config = function()
      vim.api.nvim_set_keymap('i', '<C-J>', 'copilot#Accept("\\<CR>")', { expr = true, script = true, silent = true })
      vim.g.copilot_no_tab_map = false
      vim.g.copilot_node_command = "~/.local/share/mise/installs/node/23/bin/node"
    end,
    lazy = false
  },

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {
      window = {
        width = 0.3,
      }
    }
  },
};
