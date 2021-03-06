" key bindings 

" sをトリガーっぽく使う
nnoremap s <NOP>
" {{{
  " terminalを下に開く
  nnoremap st :new<CR>:resize 15<CR>:terminal<CR>
  " 閉じる
  nnoremap sq :q<CR>
  " 下にバッファを開く
  nnoremap sn :new<CR>
  " 右にバッファを開く
  nnoremap sv :vnew<CR>
  " 右に現在バッファを複製する
  nnoremap sV :vnew %<CR>
  " 今のバッファにターミナルを開く
  nnoremap stt :terminal<CR>
  " 右に新しいTerminalを開く
  nnoremap <silent><expr> stv ":vsplit term://$SHELL \| startinsert<CR>"
  " バッファ移動
  " 左
  nnoremap sa <C-w>h 
  " 上
  nnoremap sw <C-w>k 
  " 右
  nnoremap sd <C-w>l 
  " 下
  nnoremap ss <C-w>j
  " ドキュメント全体をフォーマット
  nnoremap s= gg=G
" }}}

" インデント
nnoremap >     <S-v>>
nnoremap <     <S-v><
vnoremap >     >gv
vnoremap <     <gv

" 行の先頭と最後尾への移動
inoremap <silent> ^^ <HOME>
inoremap <silent> ^\ <END>
nnoremap <silent> ^^ <HOME>
nnoremap <silent> ^\ <END>

" jjでESC
tnoremap <silent> jj <C-\><C-n>
inoremap <silent> jj <ESC>

" バッファの削除
nnoremap <silent><expr> bd IsClosable() ? ":bdelete<CR>" : ":bp\|bd #<CR>"
" Ctrl-d でバッファを閉じる
nnoremap <silent><expr> <C-d> IsClosable() ? ":q<CR>" : ":bp\|bd #<CR>"

" Ctrl-a で全選択
nnoremap <C-a> gg<S-V>G
inoremap <C-a> <ESC>gg<S-V>G

" Ctrl-s で保存
inoremap <C-s> <ESC>:w<CR>
nnoremap <C-s> :w<CR>

" terminalでESCを使う
tnoremap <ESC> <c-\><c-n>

" Ctrl-z でもとに戻す
nnoremap <C-z> u
inoremap <C-z> <ESC>ui

" Yでクリップボードへヤンク
vnoremap Y "+y
" YY で行をクリップボードへヤンク
nnoremap YY "+yy
" AY でバッファ全体をクリップボードへヤンク
nnoremap AY gg<S-V>G"+yy

" xを虚無へ捨てる
nnoremap x "_x
