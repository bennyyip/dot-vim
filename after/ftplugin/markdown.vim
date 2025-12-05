vim9script
setlocal wrap

b:pandoc_compiler_args = '--toc --toc-depth=3 -f gfm --wrap=preserve'

import autoload 'qf.vim'

command -buffer TOC {
  set quickfixtextfunc=QF_TOC

  :lvimgrep /^\#/j %
  :lopen
  set quickfixtextfunc=qf.QuickFixText
}

def QF_TOC(info: dict<any>): list<string>
    var items = []
    if info.quickfix == 1
        items = getqflist({id: info.id, items: 1}).items
    else
        items = getloclist(info.winid, {id: info.id, items: 1}).items
    endif
    var l = []
    for idx in range(info.start_idx - 1, info.end_idx - 1)
        if items[idx].valid
            var text = ''
            text ..= $"{items[idx].text}"
            add(l, text)
        else
            add(l, items[idx].text)
        endif
    endfor
    return l
enddef

def MarkdownCR(): string
  const line = getline('.')
  if line =~# '^\d*\. .*'
    return "\<CR>1. "
  elseif line =~# '^- [.\] .*'
    return "\<CR>- [ ] "
  elseif line =~# '^- .*'
    return "\<CR>- "
  else
    return "\<CR>"
  endif
enddef

inoremap <expr> <buffer> <CR> MarkdownCR()
