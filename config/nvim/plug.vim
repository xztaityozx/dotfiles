call plug#begin()

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"{{{
  let g:airline_powerline_fonts = 1
  set laststatus=2
  let g:airline_theme='onedark'
"}}}

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"{{{
  let g:deoplete#enable_at_startup=1
  inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ deoplete#mappings#manual_complete()
	function! s:check_back_space() abort "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
	endfunction "}}}
  inoremap <expr><tab> pumvisible() ? "\<C-n>" : "\<TAB>"
  inoremap <expr><s-tab> pumvisible() ? "\<C-p>" : "\<TAB>"
  autocmd FileType cs set omnifunc=OmniSharp#Complete
  set runtimepath+=~/.config/nvim/plugged/deoplete.nvim/
"}}}

Plug 'OmniSharp/omnisharp-vim'
"{{{
  Plug 'Robzz/deoplete-omnisharp'
  Plug 'honza/vim-snippets'
  Plug 'tpope/vim-dispatch'
  Plug 'Shougo/vimproc.vim' , { 'do' : 'make' }
  Plug 'SirVer/ultisnips'
  "{{{
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<tab>"
    let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
  "}}}
  let g:OmniSharp_server_path = '$HOME/Utils/omnisharp/omnisharp/OmniSharp.exe'
  let g:OmniSharp_selector_ui = 'ctrlp'
  set previewheight=5
  let g:Omnisharp_stop_server = 0
"}}}

Plug 'nathanaelkane/vim-indent-guides' 
"{{{
  let g:indent_guides_auto_colors = 0
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#34394e ctermbg=3
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#1e2132 ctermbg=4
  let g:indent_guides_enable_on_vim_startup=1
  let g:indent_guides_start_level=2
  let g:indent_guides_guide_size=1
"}}}

Plug 'scrooloose/nerdcommenter'
"{{{
  nmap sc <Plug>NERDCommenterToggle
  vmap sc <Plug>NERDCommenterToggle
"}}}

Plug 'simeji/winresizer'
"{{{
  let g:winresizer_keycode_left=97
  let g:winresizer_keycode_up=119
  let g:winresizer_keycode_down=115
  let g:winresizer_keycode_right=100
"}}}

Plug 'Lokaltog/vim-easymotion'
"{{{
  let g:EasyMotion_do_mapping=0
  nmap sx <Plug>(easymotion-s2)
  nmap s/ <Plug>(easymotion-sn)
  xmap sx <Plug>(easymotion-s2)
  xmap s/ <Plug>(easymotion-sn)
"}}}

Plug 'Townk/vim-autoclose'
" Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/context_filetype.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'kassio/neoterm'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/syntastic'
"{{{
  let g:syntastic_cs_checkers = ['code_checker']
"}}}

call plug#end()
