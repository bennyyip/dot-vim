vim9script
if !has('win32') | finish | endif
const is_gvim = has('gui_running')

# set renderoptions=type:directx
set iminsert=2
&pythonthreedll = expand(substitute(exepath('python.exe'), 'python.exe', 'python3[0-9][0-9].dll', ''))
&pythonthreehome = substitute(exepath('python.exe'), 'python.exe', '', '')
g:netrw_cygwin = 0
g:netrw_silent = 1

if is_gvim
  augroup vimrc
    autocmd GUIEnter *  ++once simalt ~x
  augroup END
  &guifont = "Sarasa Term CL Nerd Font:h14"
  # 調整行高
  set linespace=-2
endif



def DailyNote()
  const filename = expand($HOME .. "/Obsidian-Vault/0003 Journal/" .. strftime('%Y/W%V/%Y-%m-%d') .. '.md')
  const daily_note_dir = fnamemodify(filename, ':h')
  if !isdirectory(daily_note_dir)
    call mkdir(daily_note_dir, 'p')
  endif
  fnameescape(filename)->buf.EditInTab()
enddef
def GotoObsidian()
  if expand('%:h') !~# 'Obsidian-Vault'
    echo 'Not in obsidian vault!'
    return
  endif
  const pos = getpos('.')
  call os#Open($"obsidian://adv-uri?vault=Obsidian-Vault&filepath={expand('%:t')}&line={pos[1]}&column={pos[2]}")
enddef
nnoremap <leader>v :call <SID>DailyNote()<CR>
nnoremap <leader>V <scriptcmd>GotoObsidian()<CR>
