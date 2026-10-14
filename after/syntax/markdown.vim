vim9script
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

hi link markdownError Normal
