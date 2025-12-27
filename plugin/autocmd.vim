vim9script
import autoload "../autoload/utils.vim"
import autoload '../autoload/rooter.vim'

# Functions [[[1
def JumpToLastPosition() # [[[2
  const last_pos = getpos("'\"")
  if last_pos[1] >= 1 && last_pos[1] <= line('$')
      && &filetype !~# 'commit'
      && index(['xxd', 'gitrebase'], &filetype) == -1
      && !&diff
    setpos('.', getpos("'\""))
  endif
enddef

g:format_on_save = v:false
def FormatOnSave() # [[[2
  const enalbe_ft = { c: 1, cpp: 1, ocaml: 1 }
  if get(enalbe_ft, &filetype, 0) == 0
    return
  endif

  if !get(b:, 'format_on_save', g:format_on_save)
    return
  endif
  Format()
enddef

def Format()
  if ['vim']->index(&ft) != -1
    utils.RemoveSpaces()
    return
  endif
  const save_view = winsaveview()
  :keepj normal! gggqG
  winrestview(save_view)
enddef

command! -nargs=0 Fmt Format()
nnoremap g= <scriptcmd>Format()<CR>

# Autocmd [[[1
augroup vimrc
  autocmd FocusLost * :silent! wa
  autocmd FocusGained * silent! checktime
  autocmd BufReadPost * JumpToLastPosition()
  autocmd BufWritePost * FormatOnSave()

  # create non-existent directory before buffer save
  au BufWritePre * {
    if !isdirectory(expand("%:p:h"))
      call mkdir(expand("%:p:h"), "p")
    endif
  }

  # save LAST session
  au VimLeavePre * {
    if (!has('win32') || filewritable('C:\Windows\System32') == 0)
        && getbufinfo({'bufloaded': 1, 'buflisted': 1})->len() > 1
      exe $'mksession! {$VIMSTATE}/session/LAST'
    endif
  }

  # turn on spell checker for commit messages
  autocmd FileType gitcommit,hgcommit setlocal spell
  # and emails and plain text files
  autocmd FileType mail,text setlocal spell | setlocal wrap
  # except 'help' files
  autocmd BufEnter *.txt if &filetype == 'help' | setlocal nospell | endif

  autocmd TerminalWinOpen * setlocal nonu nornu nolist signcolumn=no
  # autocmd ModeChanged *:nt setlocal relativenumber
  autocmd BufEnter * {
    rooter.Rooter()
    if &buftype == 'terminal'
      silent! wall
      # if mode() == 'n'
      #   feedkeys('i')
      # endif
    endif
  }

  # zellj EditScrollback
  autocmd BufEnter *.dump  setlocal nowrap

  # ftdetect
  autocmd BufNewFile,BufRead *.base setfiletype yaml
  autocmd BufReadPost,BufNewFile *.mly setfiletype menhir
augroup END

# FileType
for ft in ['vim', 'sh', 'zsh', 'bash', 'css', 'html', 'javascript', 'typescript', 'ps1', 'lisp', 'json', 'ocaml']
  autocmd_add([{ event: 'FileType', pattern: ft, group: 'vimrc', cmd: 'utils.SetTabWidth(2, true)' }])
endfor

for ft in ['python']
  autocmd_add([{ event: 'FileType', pattern: ft, group: 'vimrc', cmd: 'utils.SetTabWidth(4, true)' }])
endfor

for ft in ['go', 'gitconfig']
  autocmd_add([{ event: 'FileType', pattern: ft, group: 'vimrc', cmd: 'utils.SetTabWidth(4, false)' }])
endfor

for ft in ['make', 'snippets', 'neosnippet']
  autocmd_add([{ event: 'FileType', pattern: ft, group: 'vimrc', cmd: 'utils.SetTabWidth(8, false, 0)' }])
endfor

# vim -b : edit binary using xxd-format!
augroup Binary
  autocmd!
  autocmd BufReadPre  *.bin set binary
  autocmd BufReadPost *.bin {
    if &binary
      execute "silent :%!xxd"
      set filetype=xxd
      redraw
    endif
  }
  autocmd BufWritePre *.bin {
    if &binary
      w:saved_view = winsaveview()
      execute "silent :%!xxd -r"
    endif
  }
  autocmd BufWritePost *.bin {
    if &binary
      execute "silent :%!xxd"
      set nomodified
      winrestview(w:saved_view)
      redraw
    endif
  }
augroup END


# ]]]
# vim:fdm=marker:fmr=[[[,]]]:ft=vim
