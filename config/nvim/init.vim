filetype on
filetype plugin on

" vim-plug
" {{{
  if filereadable(expand('$HOME/.config/nvim/plug.vim'))
    source $HOME/.config/nvim/plug.vim
  endif
" }}}

syntax enable
set number
set expandtab
set termguicolors
set hidden
set wildmenu
set autoindent
set nostartofline
set ruler
set confirm
set mouse=a
set cmdheight=2
set backspace=indent,eol,start
set startofline
"set title
set tabstop=2
set shiftwidth=2
set list
set listchars=tab:>-,trail:-,extends:>,precedes:<,nbsp:%
set splitright
set smarttab
set incsearch
set nohlsearch
set splitbelow
set guicursor=
set background=dark
set cursorline

" python向け
" jedi docstringをださない
"autocmd FileType python setlocal completeopt-=preview
"let g:syntastic_python_checkers = ['pep8', 'pyflakes']
"function! Preserve(command)
"    " Save the last search.
"    let search = @/
"    " Save the current cursor position.
"    let cursor_position = getpos('.')
"    " Save the current window position.
"    normal! H
"    let window_position = getpos('.')
"    call setpos('.', cursor_position)
"    " Execute the command.
"    execute a:command
"    " Restore the last search.
"    let @/ = search
"    " Restore the previous window position.
"    call setpos('.', window_position)
"    normal! zt
"    " Restore the previous cursor position.
"    call setpos('.', cursor_position)
"endfunction

function! Autopep8()
    call Preserve(':silent %!autopep8 -')
endfunction

autocmd FileType python nnoremap <S-f> :call Autopep8()<CR>


" keyBind
inoremap <C-s> <ESC>:w<CR>
nnoremap <C-s> :w<CR>
tnoremap <silent> <ESC> <C-\><C-n>
nnoremap <silent> <Leader>+ <C-w>>
nnoremap <silent> <Leader>- <C-w><
nnoremap <C-d> :q<CR>
nnoremap <C-z> u
inoremap <C-z> <ESC>ui

nnoremap s <NOP>
nnoremap st :new<CR>:resize 15<CR>:terminal<CR>
nnoremap sq :q<CR>
nnoremap sl <C-w>l 
nnoremap sk <C-w>k 
nnoremap sj <C-w>j 
nnoremap sh <C-w>h 
nnoremap sa <C-w>h 
nnoremap sT :tabnew<CR>
nnoremap sn :new<CR>
nnoremap sv :vnew<CR>
nnoremap stt :terminal<CR>
nnoremap sw <C-w>k 
nnoremap sd <C-w>l 
nnoremap ss <C-w>j
nnoremap s= gg=G
inoremap <silent> ^^ <HOME>
inoremap <silent> ^\ <END>
nnoremap <silent> ^^ <HOME>
nnoremap <silent> ^\ <END>
tnoremap <silent> jj <C-\><C-n>
inoremap <silent> jj <ESC>
nnoremap sb :CtrlPBuffer<CR>
tnoremap <silent> sb <C-\><C-n>:CtrlPBuffer<CR>
nnoremap bd :bdelete<CR>
nnoremap rt <C-w>l :q<CR>
nnoremap r4 <C-w>k :q<CR>
nnoremap re <C-w>h :q<CR>
nnoremap rf <C-w>j :q<CR>

command! OpenPlugFile edit ~/.config/nvim/plug.vim
command! OpenInitFile edit ~/.config/nvim/init.vim
command! Reload source ~/.config/nvim/init.vim

autocmd FileType * colorscheme iceberg
autocmd FileType py setfiletype python
autocmd FileType cs colorscheme stellarized_dark
autocmd FileType * AirlineRefresh
