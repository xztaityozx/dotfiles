" バッファの数を返す
function g:BufferCnt() abort
  return len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
endfunction

function g:IsClosable() abort
  return BufferCnt() == winnr()
endfunction
