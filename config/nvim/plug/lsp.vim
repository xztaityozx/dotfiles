Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
"{{{
  let g:lsp_settings_rust='rls'
"}}}
Plug 'mattn/vim-lsp-icons'
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
"{{{
  let g:deoplete#enable_at_startup=1
  set completeopt-=preview
"}}}
Plug 'lighttiger2505/deoplete-vim-lsp'

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> sre <plug>(lsp-rename)
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" Diagnoticsを有効にする
let g:lsp_diagnostics_enabled = 1
" ノーマルモードでカーソル行下のDiagnoticsを出力するようにする
let g:lsp_diagnostics_echo_cursor = 1
" [実験的機能] textEditを有効にする
let g:lsp_text_edit_enabled = 1
" マーカーを表示する
let g:lsp_signs_enabled = 1

" tab completion
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y><cr>" : "\<cr>"

autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif 
