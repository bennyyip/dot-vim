" Plugin: machakann/vim-highlightedyank
if !ben#has_plugin('vim-highlightedyank')
  finish
endif

let g:highlightedyank_highlight_duration = 500

highlight link HighlightedyankRegion MatchParen
