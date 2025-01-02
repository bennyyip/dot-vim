vim9script
const is_gvim = has('gui_running')
g:gruvbox_plugin_hi_groups = 1
g:gruvbox_filetype_hi_groups = 1
if is_gvim
  g:gruvbox_italic = 1
  g:gruvbox_italicize_strings = 1
else
  g:gruvbox_italic = 1
  g:gruvbox_italicize_strings = 1
endif
