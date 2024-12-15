vim9script
import autoload "../autoload/utils.vim" as Utils


# Functions [[[1
def JumpToLastPosition() # [[[2
  const last_pos = getpos("'\"")
  if last_pos[1] >= 1 && last_pos[1] <= line('$')
    setpos('.', getpos("'\""))
  endif
enddef

# Autocmd [[[1
augroup vimrc
  autocmd FocusLost * :silent! wa
  autocmd FocusGained * silent! checktime
  autocmd TerminalWinOpen * setlocal nonu nornu nolist signcolumn=no
  autocmd BufReadPost * JumpToLastPosition()

  au VimLeavePre * :exe $'mksession! {$vimtmp}/session/LAST'
augroup END

# FileType
for ft in ['vim', 'sh', 'zsh', 'bash', 'css', 'html', 'javascript', 'typescript', 'ps1', 'lisp']
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

# ]]]
# vim:fdm=marker:fmr=[[[,]]]:ft=vim
