vim9script
augroup colorscheme_override
  autocmd!
  autocmd ColorScheme gruvbox8_hard {
    hi Pmenu guifg=NONE guibg=#3c3836 guisp=NONE gui=NONE ctermfg=NONE ctermbg=237 cterm=NONE term=reverse
    hi PmenuExtra guifg=#a89984 guibg=#3c3836 guisp=NONE gui=NONE ctermfg=102 ctermbg=237 cterm=NONE term=NONE
    hi PmenuExtraSel guifg=#a89984 guibg=#504945 guisp=NONE gui=NONE ctermfg=102 ctermbg=239 cterm=NONE term=NONE
    hi PmenuKind guifg=#fb5944 guibg=#3c3836 guisp=NONE gui=NONE ctermfg=203 ctermbg=237 cterm=NONE term=NONE
    hi PmenuKindSel guifg=#fb5944 guibg=#504945 guisp=NONE gui=NONE ctermfg=203 ctermbg=239 cterm=NONE term=NONE
    hi PmenuMatch guifg=#d3869b guibg=#3c3836 guisp=NONE gui=NONE ctermfg=175 ctermbg=237 cterm=NONE term=NONE
    hi PmenuMatchSel guifg=#d3869b guibg=#504945 guisp=NONE gui=NONE ctermfg=175 ctermbg=239 cterm=NONE term=NONE
    hi PmenuSbar guifg=NONE guibg=#3c3836 guisp=NONE gui=NONE ctermfg=NONE ctermbg=237 cterm=NONE term=reverse
    hi PmenuSel guifg=NONE guibg=#504945 guisp=NONE gui=NONE ctermfg=NONE ctermbg=239 cterm=NONE term=bold
    hi PmenuThumb guifg=NONE guibg=#7c6f64 guisp=NONE gui=NONE ctermfg=NONE ctermbg=243 cterm=NONE term=NONE
    if exists('g:lightline')
      g:lightline.colorscheme = 'gruvbox9'
    endif
  }
  autocmd ColorScheme retrobox {
    if exists('g:lightline')
      g:lightline.colorscheme = 'retrobox'
    endif
  }
augroup END

set background=dark

const fallback = get(g:, 'colorscheme_fallback', ['gruvbox8_hard', 'retrobox', 'elflord'])

for c in fallback
  try
    execute $"colorscheme {c}"
    break
  catch
    continue
  endtry
endfor

# Inspect: syntax group names under cursor
command! Inspect :echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')

# syntax
import autoload 'utils.vim'
nnoremap <leader>Si  <scriptcmd>echo utils.Syninfo()<cr>
