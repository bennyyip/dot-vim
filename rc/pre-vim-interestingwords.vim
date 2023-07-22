vim9script
# Plugin: lfv89/vim-interestingwords

g:interestingWordsDefaultMappings = 0

g:interestingWordsCycleColors = 1

nnoremap <silent> <leader>m :call InterestingWords('n')<cr>
vnoremap <silent> <leader>m :call InterestingWords('v')<cr>
nnoremap <silent> <leader>M :call UncolorAllWords()<cr>

nnoremap <silent> <leader>n :call WordNavigation(1)<cr>
nnoremap <silent> <leader>N :call WordNavigation(0)<cr>
