vim9script
if has('gui_running') | finish | endif

# if !is_ssh && has("termguicolors")
if has("termguicolors")
  # fix bug for vim
  set t_8f=[38;2;%lu;%lu;%lum
  set t_8b=[48;2;%lu;%lu;%lum

  # enable true color
  set termguicolors
endif

# cursor shapes
&t_EI = "\e[2 q"
&t_SI = "\e[6 q"
&t_SH = "\e[6 q" # terminal mode
&t_SR = "\e[3 q"
