" Plugin: haya14busa/vim-asterisk
if !ben#has_plugin('vim-asterisk')
  finish
endif

map *   ms<Plug>(asterisk-*)zzzv
map g*  ms<Plug>(asterisk-g*)zzzv
map #   ms<Plug>(asterisk-#)zzzv
map g#  ms<Plug>(asterisk-g#)zzzv
map z*  ms<Plug>(asterisk-z*)zzzv
map gz* ms<Plug>(asterisk-gz*)zzzv
map z#  ms<Plug>(asterisk-z#)zzzv
map gz# ms<Plug>(asterisk-gz#)zzzv
