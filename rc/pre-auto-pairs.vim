vim9script
g:AutoPairsCompatibleMaps = false
g:AutoPairsMapCR = true
g:AutoPairsShortcutJump = ''
g:AutoPairsShortcutToggleMultilineClose = ''
g:AutoPairsShortcutToggle = ''
g:AutoPairsShortcutIgnore = ''
g:AutoPairsMoveExpression = ''

# inoremap <silent> <c-p>s <esc>:call autopairs#Keybinds#IgnoreInsertEnterCmd(":call autopairs#AutoPairsJump()")<CR>a

nnoremap <silent> <Plug>(meta-p) :call autopairs#AutoPairsToggle()<CR>
