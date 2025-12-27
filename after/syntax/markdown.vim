syn include @tex syntax/tex.vim
syn region mkdMath start="\\\@<!\$" end="\$" skip="\\\$" contains=@tex keepend
syn region mkdMath start="\\\@<!\$\$" end="\$\$" skip="\\\$" contains=@tex keepend

syn match VimsidianLink /\v\[\[.{-}\]\]/
syn match VimsidianLinkMedia containedin=VimsidianLink /\v\!\[\[.{-}\]\]/
syn match VimsidianLinkHeader containedin=VimsidianLink /\v\[\[#.{-}\]\]/
syn match VimsidianLinkBlock containedin=VimsidianLink /\v\[\[#\^.{-}\]\]/
syn match VimsidianLinkBlockFlag /\v\^(\w)+$/
syn match VimsidianTag /\v\#(\w+)/
syn match VimsidianCallout /\v^\>(\s)+\[!(\w)+\]-?/

" syn match  mkdListItemCheckbox     /\[[xXoO\- ]\]\ze\s\+/ contained contains=mkdListItem
" syn region mkdListItemLine start="^\s*\%([-*+]\|\d\+\.\)\s\+" end="$" oneline contains=@mkdNonListItem,mkdListItem,mkdListItemCheckbox,@Spell
" hi def link mkdListItemCheckbox Type
