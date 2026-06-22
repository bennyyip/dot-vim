vim9script noclear
import autoload '../autoload/yb.vim'

if exists('g:loaded_stopwatch')
  finish
endif
g:loaded_stopwatch = 1

g:stopwatch_start_time = -1

def StopwatchReset()
  g:stopwatch_start_time = localtime()
enddef


def StopwatchNow()
  if g:stopwatch_start_time == -1
    StopwatchReset()
    StopwatchWhen()
  else
    @t = yb.FmtTime(localtime() - g:stopwatch_start_time)
    echo @t
  endif
enddef

def StopwatchWhen()
  @t = strftime("%H:%M:%S", g:stopwatch_start_time)
  echo "stopwatch begins at " .. @t
enddef

nnoremap <c-g><c-t> <scriptcmd>StopwatchNow()<CR>
nnoremap <c-g>T <scriptcmd>StopwatchWhen()<CR>
command! StopwatchReset StopwatchReset()
