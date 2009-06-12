if exists('loaded_plugin_now_restore_position')
  finish
endif
let loaded_plugin_now_restore_position = 1

let s:cpo_save = &cpo
set cpo&vim

augroup plugin-now-restore-position
  autocmd!
  autocmd BufReadPost * call s:restore_exit_view()
  autocmd BufWinLeave * call s:save_view()
  autocmd BufWinEnter * call s:restore_view()
augroup end

function! s:restore_exit_view()
  let line = line("'\"")
  if 0 < line && line <= line("$")
    call cursor(line, col("'\""))
  endif
endfunction

function! s:save_leave_point()
  let b:leave_point = winsaveview()
endfunction

function! s:restore_leave_point()
  if !exists('b:leave_point')
    return
  endif
  call winrestview(b:leave_point)
  unlet b:leave_point
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save
