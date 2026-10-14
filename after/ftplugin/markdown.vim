vim9script
import autoload 'qf.vim'

setlocal wrap

# somehow indent after <CR> is messed up
setlocal nocindent
setlocal nolisp

b:markdown_yaml_head = 1

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
