let g:cache_home = empty($XDG_CACHE_HOME) ? expand('$HOME/.cache') : $XDG_CACHE_HOME
let g:config_home = empty($XDG_CONFIG_HOME) ? expand('$HOME/.config') : $XDG_CONFIG_HOME

let g:powerline_pycmd="python3"
" dein {{{
let s:dein_cache_dir = g:cache_home . '/dein'

" reset augroup
augroup MyAutoCmd
    autocmd!
augroup END

if &runtimepath !~# '/dein.vim'
    let s:dein_repo_dir = s:dein_cache_dir . '/repos/github.com/Shougo/dein.vim'

    " Auto Download
    if !isdirectory(s:dein_repo_dir)
        call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
    endif

    " dein.vim をプラグインとして読み込む
    execute 'set runtimepath^=' . s:dein_repo_dir
endif

" dein.vim settings
let g:dein#install_max_processes = 16
let g:dein#install_progress_type = 'title'
let g:dein#install_message_type = 'none'
let g:dein#enable_notification = 1

if dein#load_state(s:dein_cache_dir)
    call dein#begin(s:dein_cache_dir)

    let s:toml_dir = g:config_home . '/dein'

    call dein#load_toml(s:toml_dir . '/dein.toml', {'lazy': 0})
    call dein#load_toml(s:toml_dir . '/dein_lazy.toml', {'lazy': 1})
    if has('nvim')
        call dein#load_toml(s:toml_dir . '/neovim.toml', {'lazy': 1})
    endif

    "call dein#add('powerline/powerline', {'rtp': 'powerline/bindings/vim/'})

    call dein#end()
    call dein#save_state()
endif

if has('vim_starting') && dein#check_install()
    call dein#install()
endif

call map(dein#check_clean(),"delete(v:val,'rf')")
" }}}
"

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
filetype on
filetype plugin on

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

tnoremap <silent> jj <C-\><C-n>
inoremap <silent> jj <ESC>

colorscheme iceberg
