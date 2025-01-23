vim9script
def ChangeArg(direction: string)
  if direction ==# 'h'
    previous
  elseif direction ==# 'l'
    next
  endif
  redraw
enddef

# press other direction to exit
nmap <Space>j <Plug>(movefast_scroll_down)
nmap <Space>k <Plug>(movefast_scroll_up)
command! FArg movefast#Init('l', { 'next': function("ChangeArg")})
command! FTab movefast#movement#tab#Prev()
