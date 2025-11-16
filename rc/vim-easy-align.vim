vim9script
xmap gl <Plug>(EasyAlign)
nmap gl <Plug>(EasyAlign)

g:easy_align_delimiters = {
 '|': { 'pattern': '[^\\]\zs|',  'left_margin': 1, 'right_margin': 1, 'stick_to_left': 0 },
}
