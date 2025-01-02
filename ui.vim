vim9script
# Apprence [[[1
const is_ssh = ($SSH_CONNECTION != "")
# Color Scheme [[[2
set background=dark
try
  colorscheme gruvbox8_hard
catch
  try
    colorscheme retrobox
  endtry
endtry
# Terminal True Color [[[2
# if !is_ssh && has("termguicolors")
if has("termguicolors")
  # fix bug for vim
  set t_8f=[38;2;%lu;%lu;%lum
  set t_8b=[48;2;%lu;%lu;%lum

  # enable true color
  set termguicolors
endif
# Change cursor style dependent on mode
# if empty($TMUX)
#   if &term =~ 'xterm' || &term == 'win32'
#     &t_SI = "\<Esc>[6 q"
#     &t_SR = "\<Esc>[3 q"
#     &t_EI = "\<Esc>[2 q"
#   else
#     &t_SI = "\<Esc>]50;CursorShape=1\x7"
#     &t_EI = "\<Esc>]50;CursorShape=0\x7"
#   endif
# else
#   &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
#   &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
# endif

&t_SI = "\<Esc>[6 q"
&t_SR = "\<Esc>[3 q"
&t_EI = "\<Esc>[2 q"

# Other [[[2
set guioptions=
# vim:fdm=marker:fmr=[[[,]]]:ft=vim
