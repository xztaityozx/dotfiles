" AirLine
" {{{
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'tpope/vim-fugitive'
  let g:airline_powerline_fonts = 1
  let g:airline_theme='onedark'
  let g:airline#extensions#tabline#enabled = 1
  let g:airline_section_warning = '%{lsp#get_buffer_diagnostics_counts()["warning"]}'
  let g:airline_section_error = '%{lsp#get_buffer_diagnostics_counts()["error"]}%{lsp#get_buffer_first_error_line()? "-".lsp#get_buffer_first_error_line():""}'
"}}}

" gitgutter
Plug 'airblade/vim-gitgutter'

" colorscheme
Plug 'cocopon/iceberg.vim'

" winresizer
" ウィンドウサイズ変更
Plug 'simeji/winresizer'
"{{{
  " Aで左に
  let g:winresizer_keycode_left=97
  " Wで上に
  let g:winresizer_keycode_up=119
  " Sで下に
  let g:winresizer_keycode_down=115
  " Dで右に
  let g:winresizer_keycode_right=100
"}}}

" 起動画面
Plug 'mhinz/vim-startify'

" syntastic
Plug 'vim-syntastic/syntastic'
" {{{
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*

  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0
" }}}

" VimDevIcons
Plug 'ryanoasis/vim-devicons'

" cursorword
Plug 'itchyny/vim-cursorword'
