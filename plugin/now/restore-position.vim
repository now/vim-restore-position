" Vim plugin file
" Maintainer:       Nikolai Weibull <now@bitwi.se>
" Latest Revision:  2006-06-14

if exists('loaded_plugin_now_restore_position')
  finish
endif
let loaded_plugin_now_restore_position = 1

let s:cpo_save = &cpo
set cpo&vim

augroup restore-position
  autocmd!
  autocmd BufReadPost * call s:restore_last_exit_point()
  autocmd BufWinLeave * call s:save_leave_point()
  autocmd BufWinEnter * call s:restore_leave_point()
augroup end

function s:restore_last_exit_point()
  let line = line("'\"")
  if line > 0 && line <= line("$")
    call cursor(line, col("'\""))
  endif
endfunction

function s:save_leave_point()
  let b:leave_point = {'line': line('.'), 'col': col('.'), 'winline': winline()}
endfunction

function s:restore_leave_point()
  if exists('b:leave_point')
    call cursor(b:leave_point.line - b:leave_point.winline + 1, 1)
    normal! zt
    call cursor(b:leave_point.line, b:leave_point.col)
    unlet b:leave_point
  endif
endfunction

let &cpo = s:cpo_save
