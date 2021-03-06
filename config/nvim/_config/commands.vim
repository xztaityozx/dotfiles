" command 
" {{{
  " 設定ファイルを開く
  command! OpenInitFile edit $NVIM_CONFIG_DIR/init.vim
  command! OpenPlugDir CtrlP $NVIM_CONFIG_DIR/plug
  command! OpenConfigDir CtrlP $NVIM_CONFIG_DIR/_config
  " リロードする
  command! Reload source $NVIM_CONFIG_DIR/init.vim
" }}}

" autocmd
" {{{
  " ファイルを開くたびにAirLineをリフレッシュする
  autocmd FileType * AirlineRefresh
" }}}
