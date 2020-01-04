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
