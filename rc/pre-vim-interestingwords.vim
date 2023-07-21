vim9script
# Plugin: lfv89/vim-interestingwords

g:interestingWordsDefaultMappings = 0

g:interestingWordsCycleColors = 1

nmap <silent> <leader>m <Plug>InterestingWords
vmap <silent> <leader>m <Plug>InterestingWords
nmap <silent> <leader>M <Plug>InterestingWordsClear

nmap <silent> <leader>n <Plug>InterestingWordsForeward
nmap <silent> <leader>N <Plug>InterestingWordsBackward
