vim9script
import autoload "../autoload/yb.vim"
import autoload '../autoload/rooter.vim'

# Functions {{{1
def JumpToLastPosition() # {{{2
  const last_pos = getpos("'\"")
  if last_pos[1] >= 1 && last_pos[1] <= line('$')
      && &filetype !~# 'commit'
      && index(['xxd', 'gitrebase'], &filetype) == -1
      && !&diff
    setpos('.', getpos("'\""))
  endif
enddef

def Format()
  if ['vim']->index(&ft) != -1
    yb.RemoveSpaces()
    return
  endif
  const save_view = winsaveview()
  :keepj normal! gggqG
  winrestview(save_view)
enddef

nnoremap g= <scriptcmd>Format()<CR>

# Autocmd {{{1
augroup vimrc
  autocmd FocusLost * :silent! wa
  autocmd FocusGained * silent! checktime
  autocmd BufReadPost * JumpToLastPosition()

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
  autocmd FileType gitcommit,hgcommit setlocal spell | hi link gitcommitBlank Normal
  # and emails and plain text files
  autocmd FileType mail,text setlocal spell | setlocal wrap
  # except 'help' files
  autocmd BufEnter *.txt if &filetype == 'help' | setlocal nospell | endif
  # always tab in makefile
  autocmd FileType make b:EditorConfig_disable = 1

  autocmd TerminalWinOpen * setlocal nonu nornu nolist signcolumn=no
  # autocmd ModeChanged *:nt setlocal relativenumber
  # autocmd BufRead * call rooter.Rooter()

  autocmd BufEnter * {
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

	au BufReadPost * silent! loadview

  # highlight brackets
  # autocmd FileType * highlight! link BenBracket Delimiter | syn match BenBracket  /[(){}\[\]]/
augroup END

# FileType
for ft in ['vim', 'sh', 'zsh', 'bash', 'css', 'html', 'javascript', 'typescript', 'ps1', 'lisp', 'json', 'ocaml']
  autocmd_add([{ event: 'FileType', pattern: ft, group: 'vimrc', cmd: 'yb.SetTabWidth(2, true)' }])
endfor

for ft in ['python']
  autocmd_add([{ event: 'FileType', pattern: ft, group: 'vimrc', cmd: 'yb.SetTabWidth(4, true)' }])
endfor

for ft in ['go', 'gitconfig', 'odin']
  autocmd_add([{ event: 'FileType', pattern: ft, group: 'vimrc', cmd: 'yb.SetTabWidth(4, false)' }])
endfor

for ft in ['make', 'snippets', 'neosnippet']
  autocmd_add([{ event: 'FileType', pattern: ft, group: 'vimrc', cmd: 'yb.SetTabWidth(8, false, 0)' }])
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


# }}}
# vim:fdm=marker:ft=vim
