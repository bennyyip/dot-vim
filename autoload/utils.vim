vim9script

export def SetTabWidth(n: number, expandtab: bool, softtabstop: number = -1) # {{{1
  execute $'setlocal shiftwidth={n} tabstop={n} softtabstop={softtabstop}'
  if expandtab
    setlocal expandtab
  else
    setlocal noexpandtab
  endif
enddef

export def RemoveSpaces() # {{{1
  if &binary || &filetype == 'diff'
    return
  endif
  const save_view = winsaveview()
  defer winrestview(save_view)
  # Trim spaces
  if &ft != 'markdown'
    keepj silent! keeppatterns :%s#\s\+$##e
  endif
  # Remove trailing blank lines
  keepj silent! keeppatterns :%s#\($\n\s*\)\+\%$##e
enddef

export def StrArray(line1: number, line2: number) # {{{1
  execute printf(":%s,%sQuote", line1, line2)
  execute printf(":%s,%sJoin ,", line1, line2)
  execute printf("normal kyss]")
enddef

export def Quote(quote: string, bang: string) # {{{1
  const q = quote == '' ? '"' : quote
  const l = getline('.')
  if l != '' || bang != '!'
    (q .. l .. q)->setline(line('.'))
  endif
enddef

export function Lilydjwg_join(sep, bang) range " {{{1
  if a:sep[0] == '\'
    let sep = strpart(a:sep, 1)
  else
    let sep = a:sep
  endif
  let lines = getline(a:firstline, a:lastline)
  if a:firstline == 1 && a:lastline == line('$')
    let dellast = 1
  else
    let dellast = 0
  endif
  exe a:firstline .. ',' .. a:lastline .. 'd_'
  if a:bang != '!'
    call map(lines, "substitute(v:val, '^\\s\\+\\|\\s\\+$', '', 'g')")
  endif
  call append(a:firstline-1, join(lines, sep))
  if dellast
    $d_
  endif
endfunction

export def SessionComplete(_, _, _): string # {{{1
  return globpath($'{$VIMSTATE}/session/', "*", 0, 1)->mapnew((_, v) => fnamemodify(v, ":t"))->join("\n")
enddef

export def FollowLink() # {{{1
  const filepath = expand('%')
  if !filereadable(filepath)
    return
  endif
  const resolved = resolve(filepath)
  if resolved ==# filepath
    return
  endif
  echom fnameescape(resolved)
  # FIXME: dont affect other window
  # enew
  # bwipeout #
  execute 'bwipeout %'
  execute 'edit ' .. fnameescape(resolved)
  redraw
enddef
# }}}
export def A(cmd: string) # Switch between .cc and .h {{{1
  const name = expand('%:r')
  const ext = tolower(expand('%:e'))
  const sources = ['c', 'cc', 'cpp', 'cxx', 'mli']
  const headers = ['h', 'hh', 'hpp', 'hxx', 'ml']
  for pair in [[sources, headers], [headers, sources]]
    const [set1, set2] = pair
    if index(set1, ext) >= 0
      for h in set2
        const aname = $'{name}.{h}'
        for a in [aname, toupper(aname)]
          if filereadable(a)
            execute $"{cmd} {a}"
            return
          endif
        endfor
      endfor
    endif
  endfor
enddef

const is_gvim = has('gui_running')
export def MapMeta() #{{{1
  for i in range(33, 122)
    const x = nr2char(i)
    for m in ["n", "c"]
      const cmd = mapcheck($"<Plug>(meta-{x})", m)
      if cmd != ""
        # echom $"{m} {x} {cmd}"
        execute is_gvim ? $"{m}map <M-{x}> <Plug>(meta-{x})"
          : $"{m}map <ESC>{x} <Plug>(meta-{x})"
      endif
    endfor
    if mapcheck($"<Plug>(meta-{x})", "i") != ""
      # map <ESC> slows entering normal mode. so only map for gui
      if is_gvim
        execute $"imap <M-{x}> <Plug>(meta-{x})"
      endif
    endif
  endfor
enddef
export def KeepChangeMarksExec(cmd: string) # {{{1
  # do not clobber '[ '] on :write
  SaveChangeMarks()
  defer RestoreChangeMarks()
  execute(cmd)
enddef
var change_marks = [[0], [0]]
def SaveChangeMarks()
  change_marks = [getpos("'["), getpos("']")]
enddef
def RestoreChangeMarks()
  setpos("'[", change_marks[0])
  setpos("']", change_marks[1])
enddef
#}}}
export def In_mkdMath(): bool # {{{1
  const in_mkdmath = map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')->index('mkdMath') >= 0
  return in_mkdmath
enddef
#}}}
export def Eatchar(pat: string): string # {{{1
  var c = nr2char(getchar(0))
  return (c =~ pat) ? '' : c
enddef
export def GenCtags() # {{{1
  var cmd = ["ctags", '-R']
  job_start(cmd, {
    exit_cb: (job, rcode) => {
      if rcode == 0
        echom "tags generated."
      else
        echom "failed to generate tags."
      endif
    },
    err_cb: (ch, msg) => {
      echom msg
    }
  })
enddef
#}}}
export def JumpToWikilink() # {{{1
  # Get the current line
  var line = getline('.')
  var col = col('.')

  # Find the wikilink that contains the cursor position
  var match_start = -1
  var match_end = -1
  var wikilink = ''

  # Search for all wikilinks on the current line
  var pattern = '\[\[.\{-}\]\]'
  var pos = 1

  while pos > 0
    var found = matchstrpos(line, pattern, pos - 1)
    if found[0] == ''
      break
    endif

    # Check if cursor is within this wikilink
    if found[1] < col - 1 && col - 1 <= found[2]
      wikilink = found[0]
      match_start = found[1]
      match_end = found[2]
      break
    endif

    pos = found[2] + 1
  endwhile

  if wikilink == ''
    echo 'No wikilink found at cursor'
    return
  endif

  # Extract the link target (everything between [[ and ]])
  var target = wikilink->strpart(2, wikilink->len() - 4)

  # Handle custom display text
  # In tables, the pipe is escaped as \|, so we need to handle both | and \|
  var pipe_pos = stridx(target, '\|')
  if pipe_pos < 0
    pipe_pos = stridx(target, '|')
  endif
  if pipe_pos >= 0
    target = target->strpart(0, pipe_pos)
  endif

  # Handle section links (text after #)
  var hash_pos = stridx(target, '#')
  var section = ''
  if hash_pos >= 0
    section = target->strpart(hash_pos + 1)
    if hash_pos == 0
      # Starts with #, this is a in-file link.
      echom section
      execute $'silent! :/^#.*{section->escape('/')}'
      return
    endif
    target = target->strpart(0, hash_pos)
  endif


  # Build the file path
  var filepath = fnameescape(target .. '.md')

  # Try to open the file
  try
    execute $"edit {g:obsidian_vault}/**/{filepath}"

    # If there's a section, jump to it
    if section != ''
      execute $'silent! :/^#.*{section->escape('/')}'
    endif
  catch /^Vim\%((\S\+)\)\=:E480:/
    # Create it on root if not exists
    execute $"edit {g:obsidian_vault}/{filepath}"
  endtry
enddef
# }}}
export def MakeComplete(_, _, _): string # {{{1
    if &shell != 'sh'
        return ""
    endif
    return system("make -npq : 2> /dev/null | awk -v RS= -F: '$1 ~ /^[^#%.]+$/ { print $1 }' | sort -u")
enddef
# 1}}}
export def PairCR(): string # {{{1
  # make it global so endwise works
  const char = getline('.')[charcol('.') - 2]
  const pairs = &mps->split(',')->map((_, x) => x->split(':'))
  for [open, close] in pairs
    if char == open
      return $"\<CR>{close}\<ESC>O"
    endif
  endfor
  return "\<CR>"
enddef
# }}}
# vim:fdm=marker:ft=vim
