let s:fzf_marks_file = $FZF_MARKS_FILE
if s:fzf_marks_file ==# ''
  let s:fzf_marks_file = $HOME . '/.fzf-marks'
endif

function! fzfmarks#callback(item)
  if len(a:item) < 2
    return
  endif
  let cmd = a:item[0]
  let content = a:item[1]
  let items = split(content, ' : ')
  if len(items) != 2 
    echoerr "fzfmarks: <" . a:item[1] . "> illegal"
    return
  endif
  let path = trim(items[1])
  if !isdirectory(path)
    echoerr "fzfmarks: <" . path . "> is not found!"
    return
  endif

  if cmd == 'ctrl-t'
    exec 'tabnew'
  endif
  exec printf('cd %s', path)
  doautocmd User FZFMarksCd
endfunction

function! fzfmarks#run()
  call fzf#run(fzf#wrap({
        \ 'source': 'cat ' . s:fzf_marks_file,
        \ 'sink*': function('fzfmarks#callback'),
        \ 'options': '--ansi --expect=ctrl-t --prompt "Path-marks > " --delimiter :',
        \ }))
endfunction
