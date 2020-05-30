
" Ctrl-P
Plug 'ctrlpvim/ctrlp.vim'
""{{{
  " CtrlPで関数定義へ飛べるプラグイン
  Plug 'tacahiroy/ctrlp-funky'
  nnoremap sf :CtrlPFunky<CR>
  " CtrlPでバッファを開く
  nnoremap sb :CtrlPBuffer<CR>
  tnoremap <silent> sb <C-\><C-n>:CtrlPBuffer<CR>
  nnoremap sl :CtrlPLine<CR>
"}}}

" nerdtree
Plug 'scrooloose/nerdtree'
"{{{
  Plug 'Xuyuanp/nerdtree-git-plugin'
  let g:NERDTreeShowIgnoredStatus = 1

  nnoremap so :NERDTreeToggle<CR>
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  let g:NERDTreeWinPos = "right"
  let g:NERDTreeWinSize = 25
"}}}
