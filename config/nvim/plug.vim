call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"{{{
  let g:airline_powerline_fonts = 1
  set laststatus=2
  let g:airline_theme='onedark'
"}}}

Plug 'tpope/vim-surround'
"{{{
"
"}}}

Plug 'junegunn/goyo.vim'
"{{{

"}}}

Plug 'SirVer/ultisnips'
"{{{
  Plug 'honza/vim-snippets'
  set runtimepath+=~/.config/nvim/snips
  let g:UltiSnipsSnippetsDir="~/.config/nvim/snips/UltiSnips"
"}}}

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"{{{
  let g:deoplete#enable_at_startup=1
  set runtimepath+=~/.config/nvim/plugged/deoplete.nvim/
  let g:auto_complete_delay=0

  "Plug 'zchee/deoplete-clang'
  ""{{{
    "let g:deoplete#sources#clang#libclang_path="/usr/lib/llvm-6.0/lib/libclang.so.1"
    "let g:deoplete#sources#clang#clang_header="/usr/lib/llvm-6.0/lib/clang"
  ""}}}
  
  Plug 'zchee/deoplete-go', { 'do': 'make'}
  "{{{
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    let g:go_addtags_transform = "camelcase"
    let g:go_fmt_command="goimports"
    let g:go_highlight_types = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_operators = 1
    Plug 'mdempsky/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
    let g:deoplete#sources#go#sort_class = ["package","const"]
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



"Plug 'nathanaelkane/vim-indent-guides' 
""{{{
  "let g:indent_guides_auto_colors = 0
  "autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#1e3221 ctermbg=3
  "autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#1e2132 ctermbg=4
  "let g:indent_guides_enable_on_vim_startup=1
  "let g:indent_guides_start_level=2
  "let g:indent_guides_guide_size=1
""}}}

Plug 'scrooloose/nerdcommenter'
"{{{
  nmap sc <Plug>NERDCommenterToggle
  vmap sc <Plug>NERDCommenterToggle
"}}}

Plug 'simeji/winresizer'
"{{{
  let g:winresizer_keycode_left=97
  let g:winresizer_keycode_up=115
  let g:winresizer_keycode_down=119
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
"}}}
Plug 'kassio/neoterm'
Plug 'airblade/vim-gitgutter'
"Plug 'scrooloose/syntastic'
""{{{
  "let g:syntastic_cs_checkers = ['code_checker']
  "let g:syntastic_cpp_compiler = 'g++'
  "let g:syntastic_cpp_compiler_options = '--std=c++14'
""}}}

"Plug 'zchee/deoplete-jedi'
""{{{
  "Plug 'tell-k/vim-autopep8'
  "autocmd FileType python noremap <buffer> <F8> :call Autopep8()<CR> 
  "" original http://stackoverflow.com/questions/12374200/using-uncrustify-with-vim/15513829#15513829
  "function! Preserve(command)
      "" Save the last search.
      "let search = @/
      "" Save the current cursor position.
      "let cursor_position = getpos('.')
      "" Save the current window position.
      "normal! H
      "let window_position = getpos('.')
      "call setpos('.', cursor_position)
      "" Execute the command.
      "execute a:command
      "" Restore the last search.
      "let @/ = search
      "" Restore the previous window position.
      "call setpos('.', window_position)
      "normal! zt
      "" Restore the previous cursor position.
      "call setpos('.', cursor_position)
  "endfunction
  
  "function! Autopep8()
      "call Preserve(':silent %!autopep8 -')
  "endfunction



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
Plug 'hauleth/blame.vim'
Plug 'miconda/lucariox.vim'
Plug 'Alvarocz/vim-northpole'
Plug 'nightsense/stellarized'
Plug 'ajmwagar/vim-deus'
Plug 'vim-scripts/DuoTones-Dark'
Plug 'Badacadabra/vim-archery'
Plug 'nightsense/nemo'
Plug 'baines/vim-colorscheme-thaumaturge'
Plug 'nightsense/seabird'
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


call plug#end()
" key-mapping for complete
" {{{
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}
inoremap <silent><expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent><expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
"" }}}
