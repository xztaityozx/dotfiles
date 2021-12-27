filetype on

" マルチバイト文字を考慮して折返す
set formatoptions+=mb
if (&ft=='md') 
  " markdownならリストを考慮する
  set formatoptions+=n
endif

" packer.nvim
lua require('plugins')
lua require('bind')
lua require('options')
lua require('default_plugin')
