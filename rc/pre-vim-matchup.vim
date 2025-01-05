vim9script
# Plugin: andymass/vim-matchup

g:matchup_transmute_enabled = 0
g:matchup_override_vimtex = 1
# g:matchup_matchparen_offscreen = {'method': 'popup'}
g:matchup_matchparen_offscreen = {}

omap am a%
omap im i%

nnoremap <c-g><c-k> :<c-u>MatchupWhereAmI?<cr>
