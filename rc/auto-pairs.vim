vim9script

g:AutoPairsMapBS = 0
g:AutoPairsMapCR = 1
g:AutoPairsMultilineFastWrap = 1
g:AutoPairsMultilineClose = 0
g:AutoPairsCompatibleMaps = 0
g:AutoPairsStringHandlingMode = 2
g:AutoPairsPreferClose = 0

g:AutoPairsShortcutJump = ''
g:AutoPairsShortcutToggleMultilineClose = ''
g:AutoPairsShortcutToggle = ''
g:AutoPairsShortcutIgnore = ''
g:AutoPairsMoveExpression = ''
g:AutoPairsFiletypeBlacklist = ['markdown', "registers"]

g:AutoPairsExperimentalAutocmd = 1

call autopairs#Variables#InitVariables()

g:AutoPairs = autopairs#AutoPairsDefine([
  {"open": '\w\zs<', "close": '>', "filetype": ["cpp", "java"]},
  {"open": "$", "close": "$", "filetype": "tex"},
  {"open": '\left(', 'close': '\right)', "filetype": "tex"},
  {'open': '\\(', 'close': '\)', 'filetype': 'tex'},
  {"open": '\v(enum|class|struct).{-} (: (.{-}[ ,])+)? ?\{', 'close': '};', 'mapopen': '{', 'filetype': ['cpp', 'c'], 'regex': 1},
  {"open": "*", "close": "*", "filetype": "help"},
  {"open": "|", "close": "|", "filetype": "help"},
  {"open": '\W\zsdo', "close": "end", "filetype": "lua", 'regex': 1},
])

if has_key(g:AutoPairsLanguagePairs["html"], "<")
  unlet g:AutoPairsLanguagePairs["html"]["<"]
endif

nnoremap <silent> <Plug>(meta-p) <scriptcmd>autopairs#AutoPairsToggle()<CR>
