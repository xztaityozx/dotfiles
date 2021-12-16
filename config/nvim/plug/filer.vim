
" Ctrl-P
Plug 'ctrlpvim/ctrlp.vim'
""{{{
  let g:ctrlp_user_command = 'fd . %s --type=f'
  let g:ctrlp_switch_buffer = 'eT'
  let g:ctrlp_open_multiple_files = '2vjr'
  let g:ctrlp_brief_prompt = '1'
  let g:ctrlp_working_path_mode = 'ra'
  function! g:ToggleCtrlPPathMode() abort
    if g:ctrlp_working_path_mode == 'ra'
      let g:ctrlp_working_path_mode = 'c'
    else
      let g:ctrlp_working_path_mode = 'ra'
    endif
  endfunction
  command! ToggleCtrlP call ToggleCtrlPPathMode()

  " CtrlPで関数定義へ飛べるプラグイン
  Plug 'tacahiroy/ctrlp-funky'
  nnoremap sf :CtrlPFunky<CR>
  " CtrlPでバッファを開く
  nnoremap sb :CtrlPBuffer<CR>
  tnoremap <silent> sb <C-\><C-n>:CtrlPBuffer<CR>
  nnoremap sl :CtrlPLine<CR>
  nnoremap <silent> sm <ESC>:<C-u>CtrlPMRUFiles<CR>
"}}}
