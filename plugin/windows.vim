vim9script
if !has('win32') | finish | endif
const is_gvim = has('gui_running')

if has('directx')
  set renderoptions=type:directx
endif

# $SHELL = 'bash'
# set shell=$SHELL

set noshellslash

set iminsert=2
&pythonthreedll = expand(substitute(exepath('python.exe'), 'python.exe', 'python3[0-9][0-9].dll', ''))
&pythonthreehome = substitute(exepath('python.exe'), 'python.exe', '', '')

g:netrw_cygwin = 0
g:netrw_silent = 1

def DailyNote()
  const filename = expand($HOME .. "/Obsidian-Vault/0003 Journal/" .. strftime('%Y/W%V/%Y-%m-%d') .. '.md')
  const daily_note_dir = fnamemodify(filename, ':h')
  if !isdirectory(daily_note_dir)
    call mkdir(daily_note_dir, 'p')
  endif
  fnameescape(filename)->buf.EditInTab()
enddef
def GotoObsidian()
  if expand('%:~') !~# 'Obsidian-Vault'
    echo 'Not in obsidian vault!'
    return
  endif
  const pos = getpos('.')
  call os#Open($"obsidian://adv-uri?vault=Obsidian-Vault&filepath={expand('%:t')}&line={pos[1]}&column={pos[2]}")
enddef
nnoremap <leader>v :call <SID>DailyNote()<CR>
nnoremap <leader>V <scriptcmd>GotoObsidian()<CR>
