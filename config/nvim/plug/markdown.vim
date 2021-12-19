" PlantUML
" {{{
  Plug 'tyru/open-browser.vim'
  let g:openbrowser_browser_commands = [{'name': 'open', 'args': ["{browser}", "{uri}"]}]

  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
" }}}
