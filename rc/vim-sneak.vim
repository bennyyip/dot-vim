vim9script
const guifg = 'white'
const guibg = '#7850a0'
const cur_guibg = '#d3869b'
const ctermfg = 'white'
const ctermbg = '5'

execute $"highlight! Sneak guifg={guifg} guibg={guibg} ctermfg={ctermfg} ctermbg={ctermbg}"
execute $"highlight! SneakCurrent guifg=black guibg={cur_guibg} ctermfg=0 ctermbg=107"
execute $"highlight! SneakLabel gui=bold cterm=bold guifg={guifg} guibg={guibg} ctermfg={ctermfg} ctermbg={ctermbg}"
execute $"highlight! SneakLabelMask guifg={guibg} guibg={guibg} ctermfg={ctermbg} ctermbg={ctermbg}"
