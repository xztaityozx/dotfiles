"{{{

  " 
  function! s:build_command(cmds) abort
    return join(map(a:cmds, {-> join(v:val, ' ')}), '|')
  endfunction

  function! TX(cmds, options) abort
    let s:cmd = s:build_command(a:cmds)
    below new | set filetype=Tnite | set nonumber | set norelativenumber |
      \ call termopen([$SHELL, "-c", s:cmd], {"on_exit": {job_id, data ->s:onExit(job_id, data, a:options)}}) | startinsert
  endfunction

  function! s:onExit(id, data, options) abort
    let s:targets=filter(getline(1, '$'), "v:val != ''")

    if a:data != 0 
      echom 'tx: command finished with non zero exit code'
      return
    endif

    close
    for item in s:targets 
      execute 'edit' item
    endfor
  endfunction

  nnoremap <silent> sk :call TX([["git", "ls-files"],["fzf", "-m"]], {})<CR>
"}}}
