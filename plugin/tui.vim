vim9script
if has('gui_running') | finish | endif

# cursor shapes
&t_EI = "\e[2 q"
&t_SI = "\e[6 q"
&t_SH = "\e[6 q" # terminal mode
&t_SR = "\e[3 q"
