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
  if !getcompletion(c, 'color')->empty()
    execute $"colorscheme {c}"
    break
  endif
endfor

# Inspect: syntax group names under cursor
command! Inspect :echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')

# syntax
nnoremap <leader>Si  <scriptcmd>echo Syninfo()<cr>

def Syninfo(): string
  const syn = Synnames()
  var info = ''
  if syn.visual != ''
    info ..= printf('visual: %s', syn.visual)
    if syn.visual != syn.visual_link
      info ..= printf(' (as %s)', syn.visual_link)
    endif
  endif
  if syn.effective != syn.visual
    if syn.visual != ''
      info ..= ', '
    endif
    info ..= printf('effective: %s', syn.effective)
    if syn.effective != syn.effective_link
      info ..= printf(' (as %s)', syn.effective_link)
    endif
  endif
  return info
enddef
def Synnames(): dict<any>
  var syn                 = {}
  const [lnum, cnum]        = [line('.'), col('.')]
  const [effective, visual] = [synID(lnum, cnum, 0), synID(lnum, cnum, 1)]
  syn.effective       = synIDattr(effective, 'name')
  syn.effective_link  = synIDattr(synIDtrans(effective), 'name')
  syn.visual          = synIDattr(visual, 'name')
  syn.visual_link     = synIDattr(synIDtrans(visual), 'name')
  return syn
enddef
