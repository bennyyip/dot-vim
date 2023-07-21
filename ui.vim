vim9script
# Apprence [[[1
const is_ssh = ($SSH_CONNECTION != "")
# Color Scheme [[[2
set background=dark
colorscheme gruvbox8
# Terminal True Color [[[2
if !is_ssh && has("termguicolors")
  # fix bug for vim
  set t_8f=[38;2;%lu;%lu;%lum
  set t_8b=[48;2;%lu;%lu;%lum

  # enable true color
  set termguicolors
endif
# Other [[[2
set guioptions=
# vim:fdm=marker:fmr=[[[,]]]:ft=vim

