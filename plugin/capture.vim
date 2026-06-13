vim9script

if !plugpac#HasPlugin('ultisnips')
  finish
endif

def Capture_Code()
  const ft = input("filetype: ", "", 'filetype')
  if ft == ""
    return
  endif
  const name = input("name: ")
  if name == ""
    return
  endif
  const path = g:obsidian_vault ..  '/0002 Notes/Programming/Code Snippets/'
    ..  strftime("%Y-%m-%d")
    .. "_" .. ft
    .. '-' .. name->substitute('\s', '-', 'g')
    .. '.md'

  const now = strftime('%FT%T%z')

  const tpl =<< trim END
    ---
    categories:
    - '[[Snippets]]'
    ctime: %s
    mtime: %s
    tags:
    - %s
    ---

    \`\`\`%s
    `!v @+`
    \`\`\`
  END

  const snippet = printf(tpl->join("\n"), now, now, ft, ft)

  execute $":tabedit {path->fnameescape()}"
  call UltiSnips#Anon(snippet)
  :write
enddef

command! -nargs=? CaptureCode {
  Capture_Code()
}
