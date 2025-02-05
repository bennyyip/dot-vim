vim9script
if empty($TMUX)
  noremap <C-h> <scriptcmd>wincmd h<CR>
  noremap <C-j> <scriptcmd>wincmd j<CR>
  noremap <C-k> <scriptcmd>wincmd k<CR>
  noremap <C-l> <scriptcmd>wincmd l<CR>
  # inoremap <C-h> <scriptcmd>wincmd h<CR>
  # inoremap <C-j> <scriptcmd>wincmd j<CR>
  # inoremap <C-k> <scriptcmd>wincmd k<CR>
  # inoremap <C-l> <scriptcmd>wincmd l<CR>
  tnoremap <C-h> <scriptcmd>wincmd h<CR>
  tnoremap <C-j> <scriptcmd>wincmd j<CR>
  tnoremap <C-k> <scriptcmd>wincmd k<CR>
  tnoremap <C-l> <scriptcmd>wincmd l<CR>
  finish
endif

if has('win32') | finish | endif

# Add and uncomment following lines to your .tmux.conf:
# bind -n C-h if "[ $(tmux display -p '#{pane_current_command}') = vim ]" "send-keys C-h" "select-pane -L"
# bind -n C-j if "[ $(tmux display -p '#{pane_current_command}') = vim ]" "send-keys C-j" "select-pane -D"
# bind -n C-k if "[ $(tmux display -p '#{pane_current_command}') = vim ]" "send-keys C-k" "select-pane -U"
# bind -n C-l if "[ $(tmux display -p '#{pane_current_command}') = vim ]" "send-keys C-l" "select-pane -R"

var tmuxSocket = split($TMUX, ',')[0]

def TmuxCommand(cmd: string): string
  return trim(system($"tmux -S {tmuxSocket} {cmd}"))
enddef

def TmuxVimNavigate(direction: string)
  var winnr = winnr()
  exe "wincmd" direction
  if winnr == winnr() && TmuxCommand("display-message -p '#{window_zoomed_flag}'") != "1"
    # Save buffer before switching to tmux
    update
    TmuxCommand($'select-pane -{tr(direction, "hjkl", "LDUR")}')
  endif
enddef

noremap <C-h> <scriptcmd>TmuxVimNavigate("h")<CR>
noremap <C-j> <scriptcmd>TmuxVimNavigate("j")<CR>
noremap <C-k> <scriptcmd>TmuxVimNavigate("k")<CR>
noremap <C-l> <scriptcmd>TmuxVimNavigate("l")<CR>
# inoremap <C-h> <scriptcmd>TmuxVimNavigate("h")<CR>
# inoremap <C-j> <scriptcmd>TmuxVimNavigate("j")<CR>
# inoremap <C-k> <scriptcmd>TmuxVimNavigate("k")<CR>
# inoremap <C-l> <scriptcmd>TmuxVimNavigate("l")<CR>
tnoremap <C-h> <scriptcmd>TmuxVimNavigate("h")<CR>
tnoremap <C-j> <scriptcmd>TmuxVimNavigate("j")<CR>
tnoremap <C-k> <scriptcmd>TmuxVimNavigate("k")<CR>
tnoremap <C-l> <scriptcmd>TmuxVimNavigate("l")<CR>
