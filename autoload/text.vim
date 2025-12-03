vim9script

# Name: autoload/text.vim
# Author: Maxim Kim <habamax@gmail.com>
# Desc: Text manipulation functions.

# number text object
export def ObjNumber()
    var rx_num = '\d\+\(\.\d\+\)*'
    if search(rx_num, 'ceW') > 0
        normal! v
        search(rx_num, 'bcW')
    endif
enddef

# Line text object
export def ObjLine(inner: bool)
    if inner
        normal! g_v^
    else
        normal! $v0
    endif
enddef

# Indent text object
# Usage:
# import autoload 'text.vim'
# onoremap <silent>ii <scriptcmd>text.ObjIndent(v:true)<CR>
# onoremap <silent>ai <scriptcmd>text.ObjIndent(v:false)<CR>
# xnoremap <silent>ii <esc><scriptcmd>text.ObjIndent(v:true)<CR>
# xnoremap <silent>ai <esc><scriptcmd>text.ObjIndent(v:false)<CR>
export def ObjIndent(inner: bool)
    var ln_start: number
    var ln_end: number
    if getline('.') =~ '^\s*$'
        ln_start = prevnonblank('.') ?? 1
    else
        ln_start = line('.')
    endif

    var indent = indent(ln_start)

    while indent == 0 && ln_start < line('$')
        ln_start = nextnonblank(ln_start + 1) ?? line('$')
        indent = indent(ln_start)
    endwhile

    if indent == 0
        return
    endif

    ln_end = ln_start

    while ln_start > 0 && indent(ln_start) >= indent
        ln_start = prevnonblank(ln_start - 1)
    endwhile

    while ln_end <= line('$') && indent(ln_end) >= indent
        ln_end = nextnonblank(ln_end + 1) ?? line('$') + 1
    endwhile

    if inner
        ln_start = nextnonblank(ln_start + 1) ?? line('$') + 1
        ln_end = prevnonblank(ln_end - 1)
    else
        ln_start += 1
        ln_end -= 1
    endif

    if ln_end < ln_start
        ln_end = ln_start
    endif

    exe ":" ln_end
    normal! V
    exe ":" ln_start
enddef

# 26 simple text objects
# ----------------------
# i_ i. i: i, i; i| i/ i\ i* i+ i- i# i<tab>
# a_ a. a: a, a; a| a/ a\ a* a+ a- a# a<tab>
# Usage:
# for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '-', '#', '<tab>' ]
#     execute $"xnoremap <silent> i{char} <esc><scriptcmd>text.Obj('{char}', 1)<CR>"
#     execute $"xnoremap <silent> a{char} <esc><scriptcmd>text.Obj('{char}', 0)<CR>"
#     execute $"onoremap <silent> i{char} :normal vi{char}<CR>"
#     execute $"onoremap <silent> a{char} :normal va{char}<CR>"
# endfor
export def Obj(char: string, inner: bool)
    var lnum = line('.')
    var echar = escape(char, '.*\')
    if (search('^\|' .. echar, 'cnbW', lnum) > 0 && search(echar, 'W', lnum) > 0)
        || (search(echar, 'nbW', lnum) > 0 && search(echar .. '\|$', 'cW', lnum) > 0)
        if inner
            search('[^' .. escape(char, '\') .. ']', 'cbW', lnum)
        endif
        normal! v
        search('^\|' .. echar, 'bW', lnum)
        if inner
            search('[^' .. escape(char, '\') .. ']', 'cW', lnum)
        endif
        return
    endif
enddef
