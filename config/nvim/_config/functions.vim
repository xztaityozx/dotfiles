" バッファの数を返す
function g:BufferCnt() abort
  return len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
endfunction

function g:IsClosable() abort
  return BufferCnt() == winnr()
endfunction

function! g:CleanEmptyBuffers()
  let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val)<0 && !getbufvar(v:val, "&mod")')
  if !empty(buffers)
    exe 'bw ' . join(buffers, ' ')
  endif
endfunction
