if exists('g:loaded_fzf_marks_vim')
  finish
endif
let g:loaded_fzf_marks_vim = 1

let s:cpo_save = &cpo
set cpo&vim

command! FZFFzm call fzfmarks#run()

let &cpo = s:cpo_save
unlet s:cpo_save
