if exists('loaded_plugin_now_restore_position')
  finish
endif
let loaded_plugin_now_restore_position = 1

let s:cpo_save = &cpo
set cpo&vim

augroup plugin-now-restore-position
  autocmd!
  autocmd BufReadPost * normal `"
  autocmd BufWinLeave * call s:save_leave_point()
  autocmd BufWinEnter * call s:restore_leave_point()
augroup end

function! s:save_leave_point()
  let b:plugin_now_restore_position_leave_point = winsaveview()
endfunction

function! s:restore_leave_point()
  if !exists('b:plugin_now_restore_position_leave_point')
    return
  endif
  call winrestview(b:plugin_now_restore_position_leave_point)
  unlet b:plugin_now_restore_position_leave_point
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save
