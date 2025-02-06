vim9script

set winaltkeys=no
set guioptions=cM!

set mousemodel=popup_setpos

if has("win32")
    set linespace=0

    # 我可以吞下玻璃，他不會傷害我
    # I can eat glasses, it doesn't hurt me
    &guifont = "Sarasa Mono CL:h16"

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

# 1liLIoO0
