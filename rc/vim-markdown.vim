vim9script
g:markdown_fenced_languages = [
  'asm',
  'bash=sh',
  'c',
  'erb=eruby',
  'javascript',
  'json',
  'perl',
  'python',
  'ruby',
  'yaml',
  'go',
  'racket',
  'haskell',
  'rust',
]

g:markdown_syntax_conceal = 1

g:vim_markdown_frontmatter = 1

g:vim_markdown_no_default_key_mappings = 1


def MapNotHasmapto(lhs: string, rhs: string)
  if !hasmapto('<Plug>' .. rhs)
    execute 'nmap <buffer>' .. lhs .. ' <Plug>' .. rhs
    execute 'vmap <buffer>' .. lhs .. ' <Plug>' .. rhs
  endif
enddef

def DoMap()
  MapNotHasmapto(']]', 'Markdown_MoveToNextHeader')
  MapNotHasmapto('[[', 'Markdown_MoveToPreviousHeader')
  MapNotHasmapto('][', 'Markdown_MoveToNextSiblingHeader')
  MapNotHasmapto('[]', 'Markdown_MoveToPreviousSiblingHeader')
  MapNotHasmapto('ge', 'Markdown_EditUrlUnderCursor')
enddef

augroup vimrc
  autocmd FileType markdown DoMap()
augroup END
