Plug 'xztaityozx/tx.nvim'
"{{{
  autocmd VimEnter * call s:tx_my_settings()
  function! s:tx_my_settings() abort
    call tx#register('rg', [
          \["rg","--vimgrep", "[[::tx_arg::]]"], 
          \["fzf","-m"],
          \["awk", "-F:", "-v OFS=:", "'{print $1,$2,$3}'"]
        \], {
          \'shellOptions':["--pipefail"],
          \'cursor': 'lc'
        \})
    call tx#register('git ls-files', [
      \["git", "ls-files"], ["fzf", "-m"]
      \], {'shellOptions': ["--pipefail"]})

    call tx#register('cd', [["fd", ".", "--type=d", "--full-path", "~/"],["fzf"]], {'vimCmd':'cd'})
    call tx#register('ssh', [["(){local host=$(cat ~/.ssh/known_hosts|awk -F'[, ]' '{print $1}'|sort -u|fzf) && echo ssh $host}"]], 
          \{
            \'shellOptions':['--pipefail'], 
            \'vimCmd':"terminal", 
            \'split':'vertical',
            \'cursor':'no'
          \})
    call tx#register('scp', [
            \["$ZDOTDIR/bin/remote-fd.zsh", "[[::tx_arg::]]"],
          \], {
            \'shellOptions': ['--pipefail'],
            \'cursor': 'no',
            \'vimCmd': 'edit'
          \}
        \)
    
    nnoremap <silent> sk :<C-u>call tx#call('git ls-files')<CR>
    nnoremap <silent> sgg :<C-u>call tx#call('rg')<CR>
    nnoremap <silent> sCd :<C-u>call tx#call('cd')<CR>
    command! Ssh call tx#call('ssh')
    command! Scp call tx#call('scp')


    " _config/bind.vimで設定してるやつと競合するので外す
    tunmap <ESC>
    tmap <silent><expr> <ESC> (&filetype == "Tx") ? "<Plug>(tx_cancel)": "<c-\><c-n>"
  endfunction
  command! TxRefresh call s:tx_my_settings()
"}}}
