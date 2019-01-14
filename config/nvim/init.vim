filetype on
filetype plugin on

let g:python_host_prog='/home/linuxbrew/.linuxbrew/Cellar/python@2/2.7.15_1/bin/python'
let g:python3_host_prog='/home/linuxbrew/.linuxbrew/Cellar/python/3.7.1/bin/python3'
let g:python3_host_skip_check = 1
set completeopt+=noselect

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
nnoremap <C-a> gg<S-V>G
inoremap <C-a> <ESC>gg<S-V>G

command! OpenPlugFile edit ~/.config/nvim/plug.vim
command! OpenInitFile edit ~/.config/nvim/init.vim
command! Reload source ~/.config/nvim/init.vim

autocmd FileType * colorscheme iceberg
autocmd FileType py setfiletype python
autocmd FileType * AirlineRefresh

