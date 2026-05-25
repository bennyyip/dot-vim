vim9script
import autoload 'qf.vim'

setlocal wrap

b:markdown_yaml_head = 1

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
  elseif line =~# '^> '
    return "\<CR>> "
  else
    return "\<CR>"
  endif
enddef

inoremap <expr> <buffer> <CR> MarkdownCR()

# XXX make css realative to <sfile>?
b:pandoc_compiler_args = $"-f gfm --wrap=preserve -c file://{expand('~')}/dotfiles/pandoc.css"
def MarkdownPreview()
  compiler pandoc
  make html
  const ssl = &shellslash
  set noshellslash
  :Open %<.html
  &shellslash = ssl
enddef
command -nargs=0 -buffer MarkdownPreview MarkdownPreview()
command -nargs=0 MarkdownPreviewDelete delete(expand('%<') .. '.html')


