vim9script
import autoload "../autoload/utils.vim" as Utils

# Vim9 [[[1
var vim9cmdline_enable = false

command Vim9cmdlineToggle {
  vim9cmdline_enable = !vim9cmdline_enable
}

augroup vim9cmdline | autocmd!
  autocmd CmdlineEnter : {
    if vim9cmdline_enable
      if visualmode() == null_string
        setcmdline('vim9 ')
      else
        setcmdline('vim9 :')
        visualmode(1)
      endif
      cnoremap        <c-u>    <c-u>vim9<space>
      cnoremap        <c-b>    <c-b><c-right><right>
      cnoremap <expr> <c-w>    getcmdpos() > 6 ? "\<c-w>" : ""
      cnoremap <expr> <c-left> getcmdpos() > 6 ? "\<c-left>" : ""
      cnoremap <expr> <bs>     getcmdpos() > 6 ? "\<bs>" : ""
      cnoremap <expr> <left>   getcmdpos() > 6 ? "\<left>" : ""
    endif
  }
  autocmd CmdlineLeave : {
    if vim9cmdline_enable
      cunmap <c-u>
      cunmap <c-w>
      cunmap <c-b>
      cunmap <c-left>
      cunmap <bs>
      cunmap <left>
    endif
  }
augroup END

# Functions [[[1
def JumpToLastPosition() # [[[2
  const last_pos = getpos("'\"")
  if last_pos[1] >= 1 && last_pos[1] <= line('$')
    setpos('.', getpos("'\""))
  endif
enddef

g:format_on_save = v:false
def FormatOnSave() # [[[2
  const enalbe_ft = { c: 1, cpp: 1 }
  if get(enalbe_ft, &filetype, 0) == 0
    return
  endif

  if !get(b:, 'format_on_save', g:format_on_save)
    return
  endif
  Format()
enddef

def Format()
  if &formatprg == '' || &formatexpr == ''
    if lsp#buffer#CurbufGetServers()->len() > 0
      LspFormat
    endif
    return
  endif
  const save_view = winsaveview()
  :keepj normal! gggqG
  # execute 'write'
  winrestview(save_view)
enddef

command! -nargs=0 Fmt Format()

# Autocmd [[[1
augroup vimrc
  au Filetype * setl formatoptions=qjlrontcm
  autocmd FocusLost * :silent! wa
  autocmd FocusGained * silent! checktime
  autocmd TerminalWinOpen * setlocal nonu nornu nolist signcolumn=no
  autocmd BufReadPost * JumpToLastPosition()
  autocmd BufWritePost * FormatOnSave()

  # create non-existent directory before buffer save
  au BufWritePre * {
    if !isdirectory(expand("%:p:h"))
      call mkdir(expand("%:p:h"), "p")
    endif
  }

  au VimLeavePre * {
    if (!has('win32') || filewritable('C:\Windows\System32') == 0)
        && getbufinfo({'bufloaded': 1, 'buflisted': 1})->len() > 1
      exe $'mksession! {$vimtmp}/session/LAST'
    endif
  }
augroup END

# FileType
for ft in ['vim', 'sh', 'zsh', 'bash', 'css', 'html', 'javascript', 'typescript', 'ps1', 'lisp', 'json', 'ocaml']
  autocmd_add([{ event: 'FileType', pattern: ft, group: 'vimrc', cmd: 'Utils.SetTabWidth(2, true)' }])
endfor

for ft in ['python']
  autocmd_add([{ event: 'FileType', pattern: ft, group: 'vimrc', cmd: 'Utils.SetTabWidth(4, true)' }])
endfor

for ft in ['go']
  autocmd_add([{ event: 'FileType', pattern: ft, group: 'vimrc', cmd: 'Utils.SetTabWidth(4, false)' }])
endfor

for ft in ['make', 'snippets']
  autocmd_add([{ event: 'FileType', pattern: ft, group: 'vimrc', cmd: 'Utils.SetTabWidth(8, false, 0)' }])
endfor
# ]]]
# vim:fdm=marker:fmr=[[[,]]]:ft=vim
