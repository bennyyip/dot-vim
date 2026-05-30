vim9script noclear

if exists('g:loaded_stopwatch')
  finish
endif
g:loaded_stopwatch = 1

g:stopwatch_start_time = -1

def StopwatchReset()
  g:stopwatch_start_time = localtime()
enddef

def FmtTime(second: number): string
  var hours = second / 3600
  var minutes = (second % 3600) / 60
  var secs = second % 60
  return printf("%02d:%02d:%02d", hours, minutes, secs)
enddef

def StopwatchNow()
  if g:stopwatch_start_time == -1
    StopwatchReset()
    StopwatchWhen()
  else
    @t = FmtTime(localtime() - g:stopwatch_start_time)
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
