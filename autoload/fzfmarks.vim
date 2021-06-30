let s:fzf_marks_file = $FZF_MARKS_FILE
if s:fzf_marks_file ==# ''
  let s:fzf_marks_file = $HOME . '/.fzf-marks'
endif

function! fzfmarks#callback(item)
  if len(a:item) < 1
    return
  endif
  let content = a:item[0]
  let items = split(content, ' : ')
  if len(items) != 2 
    echohl WarningMsg | echom "fzfmarks: <" . a:item[0] . "> illegal"
    return
  endif
  let path = trim(items[1])
  if !isdirectory(path)
      echohl WarningMsg | echom "fzfmarks: <" . path . "> is not found!" | echohl None
      return
  endif

  exec printf('cd %s', path)
  doautocmd User FZFMarksCd
endfunction

function! fzfmarks#run()
  call fzf#run(fzf#wrap({
        \ 'source': 'cat ' . s:fzf_marks_file,
        \ 'sink*': function('fzfmarks#callback'),
        \ 'options': '--delimiter :',
        \ }))
endfunction
