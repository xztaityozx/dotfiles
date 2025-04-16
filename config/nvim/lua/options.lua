local o = vim.o

-- filetype
vim.cmd('filetype plugin on')
-- ステータス行を常に表示する
o.laststatus = 2
-- UTF-8
o.encoding = "UTF-8"
-- 行番号
o.number = true
-- Tab入力時にスペースを使う
o.expandtab = true
-- Tabを入力したときに挿入される空白の数
o.tabstop = 2
-- ターミナルで背景色と前景色を使う
o.termguicolors = true
-- バッファを閉じたときに隠れバッファにする。未保存のバッファが合っても別ファイルが開けるようになる
o.hidden = true
-- コマンドライン補完を拡張する
o.wildmenu = true
-- 新しい行のインデントを前の行と同じにする
o.autoindent = true
-- 自動インデントするときに各段に挿入される空白の数
o.shiftwidth = 2

-- カーソルが何行目に置かれているかを表示する
o.ruler = true
-- バッファを保存していないときに閉じようとすると確認するように
o.confirm = true
-- すべてのモードでマウスを使えるように
o.mouse = "a"
-- コマンドラインの高さ
o.cmdheight = 2
-- バックスペースがインデント、行末、先頭を超えられるようにする
o.backspace = "indent,eol,start"
-- 先頭に移動するとき空白を無視する
o.startofline = true
-- 空白やタブを見えるようにする
o.list = true
-- tab = タブ
-- trail = 行末
-- extends = 文字が右端を超えたときに表示される文字
-- precedes = 行の先頭より前に文字がある場合に表示される文字
-- nbsp = 固定スペース
o.listchars = "tab:>-,trail:-,extends:>,precedes:<,nbsp:%"
-- ウインドウを縦分割するときに、新しいウインドウを右に開く
o.splitright = true
-- ウインドウを横分割するときに、新しいウインドウを下に開く
o.splitbelow = true
-- タブで挿入した文字をバックスペースで同じだけ消す
o.smarttab = true
-- 検索中にもマッチ部分を強調する
o.incsearch = true
-- マッチ部分を強調表示しない
vim.cmd('set nohlsearch')
-- カーソルを点滅させない
o.guicursor = ""
-- 黒背景に合うような配色をさせる
o.background = "dark"
-- カーソル行を強調表示する
o.cursorline = true
-- インサートモードでの補完設定
-- 候補とプレビューをポップアップで表示
-- 選択をユーザーにさせる
-- プレビューを表示
o.completeopt = "menuone,noselect,preview"
-- 目印行を表示する
o.signcolumn = "yes"

-- シェルを設定
if (os.getenv("OS") or ""):match("^Windows") then
  o.shell = "pwsh.exe"
  o.shellcmdflag = "-NoLogo -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
  o.shellquote="\""
  o.shellxquote=''
else
  o.shell = "/usr/bin/env zsh"
end

-- カラースキームはicebergを使う
vim.cmd('colorscheme iceberg')

