vim.cmd [[packadd packer.nvim]]
local use = require("packer").use;

return require('packer').startup({
  function()
    -- packer.nvim を packer.nvimで管理しちゃう
    use 'wbthomason/packer.nvim'

    -- easymotion
    use {
      'easymotion/vim-easymotion',
      setup = function()
        vim.g.EasyMotion_do_mapping = 0
        vim.api.nvim_set_keymap('n', 's/', '<Plug>(easymotion-sn)', { noremap = false })
        vim.api.nvim_set_keymap('x', 's/', '<Plug>(easymotion-sn)', { noremap = false })
      end,
    }

    -- nerdcommenter
    use {
      'scrooloose/nerdcommenter',
      setup = function()
        vim.api.nvim_set_keymap('n', 'sc', '<Plug>NERDCommenterToggle', { noremap = false })
        vim.api.nvim_set_keymap('v', 'sc', '<Plug>NERDCommenterToggle', { noremap = false })
      end,
    }

    use {
      'kylechui/nvim-surround',
      config = function ()
        require('nvim-surround').setup({
          keymaps = {
            -- prefixを張替え
            normal = "tt", -- ys
            normal_cur = "th", -- yss
            normal_cur_line = "tg", --yS
            visual = "t", -- S
          }
        })
        -- tf に ysiwf を割り当て、関数名が要求される
        vim.api.nvim_set_keymap('n', 'tf', '<Plug>(nvim-surround-normal)iwf', {noremap = true, silent = true})
      end
    }

    -- bufdelete
    use {
      'famiu/bufdelete.nvim',
      setup = function()
        vim.api.nvim_set_keymap('n', 'bd', '<CMD>Bdelete<CR>', { noremap = true, silent = true })
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

    -- Git関係
    -- {{{
    use 'airblade/vim-gitgutter'
    -- lazygit
    use {
      'kdheepak/lazygit.nvim',
      config = function()
        --vim.g.lazygit_floating_window_use_plenary = 1
        vim.api.nvim_set_keymap('n', 'lg', '<CMD>LazyGit<CR>', { noremap = true, silent = true })
      end
    }
    use 'f-person/git-blame.nvim'
    use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
    -- }}}

    -- ウインドウサイズ変更するやつ
    use {
      'simeji/winresizer',
      setup = function()
        -- Aで左に
        vim.g.winresizer_keycode_left = 97
        -- Wで上に
        vim.g.winresizer_keycode_up = 119
        -- Sで下に
        vim.g.winresizer_keycode_down = 115
        -- Dで右に
        vim.g.winresizer_keycode_right = 100
      end
    }

    -- lspの設定
    use {
      "jose-elias-alvarez/null-ls.nvim",
      requires = {
        "nvim-lua/plenary.nvim"
      },
      config = function()
        require("null-ls").setup()
      end
    }

    -- outlineを表示したりできるやつ
    use {
      'stevearc/aerial.nvim',
      config = function() require('aerial').setup() end
    }

    use {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    }

    require('mason').setup();
    require('mason-lspconfig').setup_handlers({ function(server)
      local opt = {
        capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
        on_attach = function(_, bufnr)
          local opts = { noremap = true, silent = true }
          vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'i', '<C-Space>', '<cmd>lua vim.lsp.buf.completion()<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-R><C-R>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', 'sq', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.format({async = true})<CR>', opts)
          vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
          vim.keymap.set({ "v", "n" }, 'sA', require('actions-preview').code_actions, opts)
        end
      };
      if server == "lua_ls" then
        local runtime_path = vim.split(package.path, ";", {});
        table.insert(runtime_path, "lua/?.lua")
        table.insert(runtime_path, "lua/*/init.lua")
        opt.settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
              path = runtime_path,
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
      end

      if server == "perlnavigator" then
        local pwd = os.getenv("PWD");
        opt.settings = {
          perlnavigator = {
            perlPath = 'perl',
            enableWarnings = true,
            perltidyProfile = pwd .. '/.perltidyrc',
            perlcriticProfile = pwd .. '/.perlcriticrc',
            perlcriticEnabled = true,
            includePaths = { pwd .. '/lib', pwd .. '/local/lib/perl5', pwd .. '/.libt' },
          }
        };
        opt.cmd = { "perlnavigator", "--stdio" }
      end
      require('lspconfig')[server].setup(opt)
    end })

    use {
      'neovim/nvim-lspconfig',
      requires = {
        { 'nvim-lua/lsp-status.nvim' },
        { 'folke/lsp-colors.nvim' },
        { 'folke/neodev.nvim' },
      },
      config = function()
        -- disableCacheしてもキャッシュが作成されるしつらい
        --require('lspconfig').perlls.setup {
          --cmd = { "perl", "-MPerl::LanguageServer", "-e", "Perl::LanguageServer::run", "--", "--port 13603",
            --"--nostdio 0", "--version 2.5.0" },
          --settings = {
            --perl = {
              --disableCache = true,
            --}
          --}
        --};
      end
    }

    use {
      "nvim-tree/nvim-web-devicons",
      config = function()
        require('nvim-web-devicons').setup({
          color_icons = true
        })
      end
    }

    use {
      'folke/trouble.nvim',
      config = function()
        local trouble = require('trouble')
        trouble.setup({
          icons = true,
          fold_open = '',
          fold_closed = '',
          signs = {
            error = '',
            warning = '',
            hint = '',
            information = '',
            other = ''
          },
          use_diagnostic_signs = false,
          auto_open = false,
          auto_close = true,
        })
      end,
      setup = function()
        vim.api.nvim_set_keymap('n', 's[', '<cmd>TroubleToggle<CR>', { silent = true, noremap = true })
      end
    }

    -- 補完
    use {
      'hrsh7th/nvim-cmp',
      requires = {
        { 'neovim/nvim-lspconfig' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-cmdline' },
        { 'L3MON4D3/LuaSnip' },
        { 'saadparwaiz1/cmp_luasnip' }
      },
      config = function()
        local cmp = require('cmp')
        cmp.setup({
          view = 'custom',
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
            { name = 'luasnip' }
          },
            {
              { name = 'buffer' },
              { name = 'path' },
            })
        })
        cmp.setup.cmdline(':', {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            { name = 'path' }
          }, {
            { name = 'cmdline' }
          })
        })
      end
    }

    -- シグネチャヒント
    use {
      "ray-x/lsp_signature.nvim",
      config = function()
        require('lsp_signature').setup({
          bind = true,
          handler_opts = {
            border = "rounded"
          },
          floating_window = true,
          toggle_key = '<C-l>',
          hint_prefix = ''
        })
      end
    }

    -- ステータスライン
    use {
      'nvim-lualine/lualine.nvim',
      requires = {
        { 'kdheepak/tabline.nvim', config = function() require('tabline').setup({ enable = false }) end },
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
            lualine_x = { "require('lsp-status').status()" },
            lualine_y = { 'encoding',
              { 'fileformat', symbols = { unix = ' Linux', dos = ' Windows', mac = ' macOS' } } },
            lualine_z = { 'location', custom_progress },
          },
          tabline = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { require 'tabline'.tabline_buffers },
            lualine_y = {},
            lualine_z = { 'tabs' },
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
          }
        })
      end
    }

    -- カーソル下にある単語と同じ奴にアンダーラインがつくやつ
    use 'itchyny/vim-cursorword'

    -- treesitter
    use {
      'nvim-treesitter/nvim-treesitter',
      config = function()
        require('nvim-treesitter.configs').setup({
          indent = {
            enable = true,
          },
          --なんか急にハイライト死んだ
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
    -- インデントのガイドラインを表示するくん
    use {
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        require('indent_blankline').setup({
          show_current_context = true,
          show_current_context_start = true
        })
      end
    }

    -- terminal系
    use {
      'akinsho/toggleterm.nvim',
      config = function()
        require('toggleterm').setup({})

        vim.api.nvim_set_keymap('n', '<F3>', '<cmd>ToggleTerm direction=float<CR>', {noremap = true, silent = true})
        vim.api.nvim_set_keymap('n', '<F4>', '<cmd>ToggleTerm direction=horizontal<CR>', {noremap = true, silent = true})
        vim.api.nvim_set_keymap('t', '<F3>', '<cmd>ToggleTerm direction=float<CR>', {noremap = true, silent = true})
        vim.api.nvim_set_keymap('t', '<F4>', '<cmd>ToggleTerm direction=horizontal<CR>', {noremap = true, silent = true})
      end
    }

    -- colorscheme
    use { 'cocopon/iceberg.vim', opt = true }

    -- fuzzy finder
    use {
      'nvim-telescope/telescope.nvim',
      requires = {
        { 'nvim-lua/plenary.nvim' },
        use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      },
      config = function()
        vim.api.nvim_set_keymap('n', '<C-p>', "<cmd>Telescope find_files<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', 'sb', "<cmd>Telescope buffers<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', 'sg', "<cmd>Telescope live_grep<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', 'sh', "<cmd>Telescope help_tags<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', 'sx', "<cmd>Telescope grep_string<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', 'sm', "<cmd>Telescope oldfiles<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', 's"', "<cmd>Telescope registers<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', 'sQ', "<cmd>Telescope quickfix<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', 'sf', "<cmd>Telescope aerial<CR>", { noremap = true, silent = true })

        -- lsp系
        vim.api.nvim_set_keymap('n', 'gd', "<cmd>Telescope lsp_definitions<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', 'gT', "<cmd>Telescope lsp_type_definitions<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', 'sD', "<cmd>Telescope diagnostics<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', 'gr', "<cmd>Telescope lsp_references<CR>", { noremap = true, silent = true })

        require('telescope').setup({
          defaults = {
            sorting_strategy = 'ascending',
            layout_strategy = 'horizontal',
            layout_config = { prompt_position = "top" },
            mappings = {
              i = {
                ["<esc>"] = require('telescope.actions').close,
              },
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
        require('telescope').load_extension('aerial')
      end
    }
    use 'nvim-treesitter/nvim-treesitter-context'
    use {
      'kosayoda/nvim-lightbulb',
      config = function()
        require('nvim-lightbulb').setup({
          autocmd = { enabled = true },
          virtual_text = { enabled = false }
        })
      end,
    }

    use {
      "aznhe21/actions-preview.nvim",
      config = function()
        require("actions-preview").setup {
          -- バックエンドに使うプラグインの優先順位。デフォルトではtelescopeを優先的に使う
          -- backend = { "nui", "telescope" },
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
        }
      end
    }

    -- copilot
    use { 
      'github/copilot.vim',
      config = function()
        -- Ctrl+j でCopilotの候補を選択
        vim.api.nvim_set_keymap('i', '<C-J>', 'copilot#Accept("\\<CR>")', {expr = true, script = true, silent = true})
        vim.g.copilot_no_tab_map = false
      end
    }
  end,
  config = {
    display = {
      open_fn = require('packer.util').float,
    }
  }
});
