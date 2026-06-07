vim9script

set winaltkeys=no
set guioptions=cM!

set mousemodel=popup_setpos

if has("win32")
  # set linespace=0

  # 我可以吞下玻璃，他不會傷害我
  # I can eat glasses, it doesn't hurt me
  # 1liLIoO0
  # <= >=
  # A QUICK BRWON FOX JUMPS OVER A LAZY DOG
  # a quick brwon fox jumps over a lazy dog
  # 0123456789

  if has('directx')
    set renderoptions=type:directx
    # &guifont = "Sarasa Fixed CL:h16:fcalt=0:fss20=1"
    &guifont = "Iosevka Fixed Curly:h16"
    &guifontwide = "Sarasa Fixed CL:h16"

    # &guifont = "Consolas:h24,Symbols Nerd Font Mono,Chiron Hei HK"

    # &guifont = "Sarasa Fixed CL:h16"
    # &guifont = "Iosevka Fixed Curly:h16,Symbols Nerd Font:h16,Chiron Hei HK:h16"
  endif

  # :h w32-experimental-keycode-trans-strategy
  # Should fix CTRL-=
  augroup mswin_strat | au!
    au VimEnter * test_mswin_event('set_keycode_trans_strategy', {'strategy': 'experimental'})
    autocmd GUIEnter *  ++once simalt ~x
  augroup END
else
  set guifont=Monospace\ 19
endif


nnoremap <silent> <C-=> <scriptcmd>guifont_size#Change('inc', v:count1)<CR>
nnoremap <silent> <C-_> <scriptcmd>guifont_size#Change('dec', v:count1)<CR>
nnoremap <silent> <C-0> <scriptcmd>guifont_size#Change('restore')<CR>
imap <C-S> <ESC>:w<CR>

set guicursor+=a:blinkoff0
