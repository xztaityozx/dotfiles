Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" {{{
  let g:go_addtags_transform = "camelcase"
  let g:go_fmt_command="goimports"
  let g:go_highlight_types = 1
  let g:go_highlight_methods = 1
  let g:go_highlight_operators = 1
  autocmd FileType go nnoremap gr :GoRun<CR>
  autocmd FileType go nnoremap gt :GoTest<CR>
  autocmd FileType go nnoremap gi :GoImport 
" }}}
