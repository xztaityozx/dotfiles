filetype on
filetype plugin on

" シンタックスハイライトをON
syntax enable

" ステータス行を常に表示する
set laststatus=2
" マルチバイト文字を考慮して折返す
set formatoptions+=mb
if (&ft=='md') 
  " markdownならリストを考慮する
  set formatoptions+=n
endif

" 行番号
set number
" Tab入力時にスペースを使う
set expandtab
" Tabを入力したときに挿入される空白の数
set tabstop=2
" ターミナルで背景色と前景色を使う
set termguicolors
" バッファを閉じたときに隠れバッファにする。未保存のバッファが合っても別ファイルが開けるようになる
set hidden
" コマンドライン補完を拡張する
set wildmenu
" 新しい行のインデントを前の行と同じにする
set autoindent
" 自動インデントするときに各段に挿入される空白の数
set shiftwidth=2
" カーソルが何行目に置かれているかを表示する
set ruler
" バッファを保存していないときに閉じようとすると確認するように
set confirm
" すべてのモードでマウスを使えるように
set mouse=a
" コマンドラインの高さ
set cmdheight=2
" バックスペースがインデント、行末、先頭を超えられるようにする
set backspace=indent,eol,start
" 先頭に移動するとき空白を無視する
set startofline
" 空白やタブを見えるようにする
set list
" tab = タブ
" trail = 行末
" extends = 文字が右端を超えたときに表示される文字
" precedes = 行の先頭より前に文字がある場合に表示される文字
" nbsp = 固定スペース
set listchars=tab:>-,trail:-,extends:>,precedes:<,nbsp:%
" ウインドウを縦分割するときに、新しいウインドウを右に開く
set splitright
" ウインドウを横分割するときに、新しいウインドウを下に開く
set splitbelow
" タブで挿入した文字をバックスペースで同じだけ消す
set smarttab
" 検索中にもマッチ部分を強調する
set incsearch
" マッチ部分を強調表示しない
set nohlsearch
" カーソルを点滅させない
set guicursor=
" 黒背景に合うような配色をさせる
set background=dark
" カーソル行を強調表示する
set cursorline
" インサートモードでの補完設定
" 候補とプレビューをポップアップで表示
" 選択をユーザーにさせる
" プレビューを表示
set completeopt=menuone,noselect,preview
" 目印行を表示する
set signcolumn=yes
" 折り畳み方を{{{}}}で囲まれた部分にする
set foldmethod=marker
set foldlevel=2

" shell設定
setglobal shell=$SHELL

" いくつかのdefault-pluginを読み込まない
" {{{
  " gzip, tar, zip 閲覧用
  let g:loaded_gzip              = 1
  let g:loaded_tar               = 1
  let g:loaded_tarPlugin         = 1
  let g:loaded_zip               = 1
  let g:loaded_zipPlugin         = 1
  " vimball
  let g:loaded_rrhelper          = 1
  let g:loaded_2html_plugin      = 1
  let g:loaded_vimball           = 1
  let g:loaded_vimballPlugin     = 1
  let g:loaded_getscript         = 1
  let g:loaded_getscriptPlugin   = 1
" }}}

" a:pathをglob展開してsourceする関数
function! s:source_files(path) abort 
    call map(sort(split(globpath(&rtp, a:path))), {->[execute('exec "source" v:val')]})
endfunction

" vim-plug
" {{{
  call plug#begin()
    " 設定ファイルをいろいろ読み込む
    call s:source_files('plug/*.vim')
  call plug#end()
" }}}

" 他の設定ファイルを読み込む
" {{{
  call s:source_files('_config/*.vim')
" }}}

" colorschemeにicebergを使う
colorscheme iceberg
