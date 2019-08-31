call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"{{{
  let g:airline_powerline_fonts = 1
  set laststatus=2
  let g:airline_theme='onedark'
  let g:airline#extensions#tabline#enabled = 1
"}}}

Plug 'sheerun/vim-polyglot'
"{{{
"
"}}}

Plug 'tpope/vim-surround'
"{{{
"
"}}}

Plug 'junegunn/goyo.vim'
"{{{

"}}}

Plug 'OmniSharp/omnisharp-vim'
"{{{
  let g:OmniSharp_server_stdio=1
  let g:OmniSharp_selector_ui = 'ctrlp'
"}}}

"Plug 'SirVer/ultisnips'
""{{{
  "Plug 'honza/vim-snippets'
  "set runtimepath+=~/.config/nvim/snips
  "let g:UltiSnipsSnippetsDir="~/.config/nvim/snips/UltiSnips"
"}}}

"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
""{{{
  "let g:deoplete#enable_at_startup=1
  "set runtimepath+=~/.config/nvim/plugged/deoplete.nvim/
  "let g:auto_complete_delay=0
  
  
"  Plug 'zchee/deoplete-go', { 'do': 'make'}
"  "{{{
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    let g:go_addtags_transform = "camelcase"
    let g:go_fmt_command="goimports"
    let g:go_highlight_types = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_operators = 1
    autocmd FileType go nnoremap gr :GoRun<CR>
    autocmd FileType go nnoremap gt :GoTest<CR>
    autocmd FileType go nnoremap gi :GoImport 
    autocmd FileType go nnoremap gb :GoBuild<CR>
    autocmd FileType go nnoremap gf :GoFmt<CR>
    autocmd FileType go nnoremap go :GoDoc 
    autocmd FileType go nnoremap gI :GoInfo<CR>
  "}}}
"}}}
"

Plug 'neoclide/coc.nvim', {'do': 'yarn install'}
"{{{
  set hidden
  set signcolumn=yes
  
  inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  inoremap <silent><expr> <c-space> coc#refresh()
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

  " For vim-airline integration
  let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
  let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

  Plug 'tjdevries/coc-zsh'

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
"{{{
  Plug 'liquidz/ctrlp-gonosen.vim'
  nnoremap sg :CtrlPGonosen<CR>
  Plug 'tacahiroy/ctrlp-funky'
  nnoremap sf :CtrlPFunky<CR>
"}}}
Plug 'kassio/neoterm'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
"{{{
  Plug 'Xuyuanp/nerdtree-git-plugin'
  let g:NERDTreeShowIgnoredStatus = 1

  nnoremap so :NERDTreeToggle<CR>
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  let g:NERDTreeWinPos = "right"
  let g:NERDTreeWinSize = 25
"}}}

" colorschemes
" {{{
Plug 'rhysd/try-colorscheme.vim'
Plug 'nightsense/seabird'
Plug 'cocopon/iceberg.vim'
" }}}

" QuickRun
Plug 'thinca/vim-quickrun'
"{{{
  let g:quickrun_config={}
  let g:quickrun_config['cpp/clang++14'] = {
      \ 'cmdopt': '--std=c++14',
      \ 'type': 'cpp/clang++'
    \ }
  let g:quickrun_config['cpp'] = {'type': 'cpp/clang++14'}
"}}}

" for Python settings
" {{{
  Plug 'tell-k/vim-autopep8'
  autocmd FileType python nnoremap sp :Autopep8<CR>
" }}}

call plug#end()
" key-mapping for complete
" {{{
"inoremap <silent><expr> <TAB>
  "\ pumvisible() ? "\<C-n>" :
  "\ <SID>check_back_space() ? "\<TAB>" :
  "\ deoplete#mappings#manual_complete()
"function! s:check_back_space() abort "{{{
  "let col = col('.') - 1
  "return !col || getline('.')[col - 1]  =~ '\s'
"endfunction"}}}
"inoremap <silent><expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"inoremap <silent><expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
"let g:UltiSnipsExpandTrigger="<C-j>"
"let g:UltiSnipsJumpForwardTrigger="<tab>"
"let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
"" }}}
