" vim: et sw=2 sts=2

" Plugin:      https://github.com/mhinz/vim-yat
" Description: A fancy start screen for Vim.
" Maintainer:  Marco Hinz <http://github.com/mhinz>

if exists("b:current_syntax")
  finish
endif

let s:sep = '/'
let s:padding_left = repeat(' ', get(g:, 'yat_padding_left', 3))

syntax sync fromstart

execute 'syntax match YatBracket /.*\%'. (len(s:padding_left) + 6) .'c/ contains=
      \ YatNumber,
      \ YatSelect'
syntax match YatSpecial /\V<empty buffer>\|<quit>/
syntax match YatNumber  /^\s*\[\zs[^BSVT]\{-}\ze\]/
syntax match YatSelect  /^\s*\[\zs[BSVT]\{-}\ze\]/
syntax match YatVar     /\$[^\/]\+/
syntax match YatFile    /.*/ contains=
      \ YatBracket,
      \ YatPath,
      \ YatSpecial,

execute 'syntax match YatSlash /\'. s:sep .'/'
execute 'syntax match YatPath /\%'. (len(s:padding_left) + 6) .'c.*\'. s:sep .'/ contains=YatSlash,YatVar'

execute 'syntax region YatHeader start=/\%1l/ end=/\%'. (len(g:yat_header) + 2) .'l/'

if exists('g:yat_custom_footer')
  execute 'syntax region YatFooter start=/\%'. yat#get_lastline() .'l/ end=/\_.*/'
endif

if exists('b:yat_section_header_lines')
  for line in b:yat_section_header_lines
    execute 'syntax region YatSection start=/\%'. line .'l/ end=/$/'
  endfor
endif

highlight default link YatBracket Delimiter
highlight default link YatFile    Identifier
highlight default link YatFooter  Title
highlight default link YatHeader  Title
highlight default link YatNumber  Number
highlight default link YatPath    Directory
highlight default link YatSection Statement
highlight default link YatSelect  Title
highlight default link YatSlash   Delimiter
highlight default link YatSpecial Comment
highlight default link YatVar     YatPath

hi YatBracket guifg=#bdae93 guibg=NONE guisp=NONE gui=NONE cterm=NONE
hi YatFile guifg=#ebdbb2 guibg=NONE guisp=NONE gui=NONE cterm=NONE
hi YatFooter guifg=#504945 guibg=NONE guisp=NONE gui=NONE cterm=NONE
hi YatHeader guifg=#fabd2f guibg=NONE guisp=NONE gui=NONE cterm=NONE
hi YatNumber guifg=#83a598 guibg=NONE guisp=NONE gui=NONE cterm=NONE
hi YatPath guifg=#928374 guibg=NONE guisp=NONE gui=NONE cterm=NONE
hi YatSection guifg=#fabd2f guibg=NONE guisp=NONE gui=NONE cterm=NONE
hi YatSlash guifg=#928374 guibg=NONE guisp=NONE gui=NONE cterm=NONE
hi YatSpecial guifg=#504945 guibg=NONE guisp=NONE gui=NONE cterm=NONE

let b:current_syntax = 'yat'

