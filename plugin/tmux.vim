vim9script
if empty($TMUX) && empty($ZELLIJ)
  noremap <C-h> <scriptcmd>wincmd h<CR>
  noremap <C-j> <scriptcmd>wincmd j<CR>
  noremap <C-k> <scriptcmd>wincmd k<CR>
  noremap <C-l> <scriptcmd>wincmd l<CR>
  inoremap <C-h> <scriptcmd>wincmd h<CR>
  inoremap <C-j> <scriptcmd>wincmd j<CR>
  inoremap <C-k> <scriptcmd>wincmd k<CR>
  inoremap <C-l> <scriptcmd>wincmd l<CR>
  tnoremap <C-h> <scriptcmd>wincmd h<CR>
  tnoremap <C-j> <scriptcmd>wincmd j<CR>
  tnoremap <C-k> <scriptcmd>wincmd k<CR>
  tnoremap <C-l> <scriptcmd>wincmd l<CR>
  finish
endif

if has('win32') | finish | endif

def TmuxCommand(cmd: string): string
  const tmuxSocket = split($TMUX, ',')[0]
  return trim(system($"tmux -S {tmuxSocket} {cmd}"))
enddef

def ZelljAction(cmd: string)
      job_start($"zellij action {cmd}")
enddef

const DIRECTIONS = {h: 'left', j: 'down', k: 'up', l: 'right'}

def Navigate(direction: string)
  var winnr = winnr()
  exe "wincmd" direction
  if winnr == winnr()
    # Save buffer before switching to tmux
    silent! update
    if !empty($TMUX) && TmuxCommand("display-message -p '#{window_zoomed_flag}'") != "1"
      TmuxCommand($'select-pane -{tr(direction, "hjkl", "LDUR")}')
    endif
    if !empty($ZELLIJ)
      ZelljAction($"move-focus {DIRECTIONS[direction]}")
    endif
  endif
enddef

noremap  <C-h> <scriptcmd>Navigate("h")<CR>
noremap  <C-j> <scriptcmd>Navigate("j")<CR>
noremap  <C-k> <scriptcmd>Navigate("k")<CR>
noremap  <C-l> <scriptcmd>Navigate("l")<CR>
inoremap <C-h> <scriptcmd>Navigate("h")<CR>
inoremap <C-j> <scriptcmd>Navigate("j")<CR>
inoremap <C-k> <scriptcmd>Navigate("k")<CR>
inoremap <C-l> <scriptcmd>Navigate("l")<CR>
# inoremap <expr> <C-l> pumvisible() ? "\<C-L>" : Navigate("l")
tnoremap <C-h> <scriptcmd>Navigate("h")<CR>
tnoremap <C-j> <scriptcmd>Navigate("j")<CR>
tnoremap <C-k> <scriptcmd>Navigate("k")<CR>
tnoremap <C-l> <scriptcmd>Navigate("l")<CR>

if !empty($ZELLIJ)
  noremap <Plug>(meta-m) <scriptcmd>ZelljAction("toggle-floating-panes")<CR>
endif

command! -nargs=1 -complete=shellcmdline ZellijRun {
   job_start("zellij run -- " .. <q-args>)
}

command! -nargs=1 -complete=shellcmdline ZellijRunFloat {
   job_start("zellij run -f -- " .. <q-args>)
}
