" nerdcommenter
Plug 'scrooloose/nerdcommenter'
"{{{
  nmap sc <Plug>NERDCommenterToggle
  vmap sc <Plug>NERDCommenterToggle
"}}}

" vim-surround
Plug 'tpope/vim-surround'

" カッコとかの自動補完
Plug 'cohama/lexima.vim'

" nvim fo browser
"Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
"function! s:IsFirenvimActive(event) abort
  "if !exists('*nvim_get_chan_info')
    "return 0
  "endif
  "let l:ui = nvim_get_chan_info(a:event.chan)
  "return has_key(l:ui, 'client') && has_key(l:ui.client, 'name') &&
      "\ l:ui.client.name =~? 'Firenvim'
"endfunction
"function! Set_GuiFont(event) abort
  "if s:IsFirenvimActive(a:event)
    "execute 'set guifont=Cica:h12'
  "endif
"endfunction
"autocmd UIEnter * call Set_GuiFont(deepcopy(v:event))

"augroup Firenvim
  "au BufEnter github.com_*.txt set filetype=markdown
"augroup END
