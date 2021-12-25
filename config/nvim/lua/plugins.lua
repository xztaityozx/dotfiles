vim.cmd [[packadd packer.nvim]]

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

  -- カッコとかの自動補完
  use 'cohama/lexima.vim'

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
    'neovim/nvim-lspconfig',
    requires = {
      {'nvim-lua/lsp-status.nvim'},
      {'folke/lsp-colors.nvim'},
      {'williamboman/nvim-lsp-installer'}
    },
  }
  local on_attach = function()
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }

    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', 'gT', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', 'sR', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', 'sA', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  end
  require('lspconfig').gopls.setup({ on_attach = on_attach })

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
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup({
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
          {name = 'nvim_lsp'}
        },
        {
          {name = 'buffer'},
          {name = 'path'},
        })
      })
      local cap = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
      require('lspconfig')['gopls'].setup({
        capabilities = cap
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
            'diagnostics'
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

  -- colorscheme
  use {'cocopon/iceberg.vim', opt = true}


end, config = {
display = {
  open_fn = require('packer.util').float,
}
}})
