let s:is_gvim = has('gui_running')
let g:gruvbox_material_background = 'hard'
let g:gruvbox_plugin_hi_groups = 1
let g:gruvbox_filetype_hi_groups = 1
if s:is_gvim
  let g:gruvbox_italic = 1
  let g:gruvbox_italicize_strings = 1
else
  let g:gruvbox_italic = 0
  let g:gruvbox_italicize_strings = 0
endif

