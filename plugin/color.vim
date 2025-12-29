vim9script

if has("termguicolors") && !has('gui_running')
  # fix bug for vim
  set t_8f=[38;2;%lu;%lu;%lum
  set t_8b=[48;2;%lu;%lu;%lum

  # enable true color
  set termguicolors
endif

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
    hi! link debugBreakpoint ErrorMsg
    hi! link debugPC QuickFixLine

    hi StatusLine guifg=#ebdbb2 guibg=#12253b guisp=NONE gui=NONE ctermfg=187 ctermbg=235 cterm=NONE term=bold,reverse
    hi StatusLineBold guifg=#ebdbb2 guibg=#12253b guisp=NONE gui=bold ctermfg=187 ctermbg=235 cterm=bold term=bold
    hi StatusLineInsert   term=bold   cterm=bold  ctermfg=234   ctermbg=109 gui=bold guifg=#1c1c1c guibg=#82a598
    hi StatusLineVisual   term=bold   cterm=bold  ctermfg=234   ctermbg=214 gui=bold guifg=#1c1c1c guibg=#fabd2f
    hi! link StatusLineNormal StatusLineBold
    hi StatusLineReplace  term=bold   cterm=bold  ctermfg=234   ctermbg=203 gui=bold guifg=#1c1c1c guibg=#fb4934

    hi TabLine      ctermfg=137 ctermbg=239 guifg=#a89984 guibg=#504945
    hi TabLineSel   term=bold   cterm=bold  ctermfg=234   ctermbg=137 gui=bold guifg=#1c1c1c guibg=#a89984
    hi TabLineFill none
    hi! TabLineRight ctermfg=234 ctermbg=208 guifg=#1c1c1c guibg=#fe8019

    hi Folded guibg=#d5c4a1 guifg=#3c3836
  }
augroup END

const hour = strftime('%H')->str2nr()
if get(g:, 'colorscheme_light', false) && hour > 8 && hour < 18
  set background=light
else
  set background=dark
endif

var fallback = ['retrobox', 'gruvbox8_hard', 'elflord']
if has('gui_running')
  fallback = ['flexoki', 'retrobox', 'gruvbox8_hard', 'elflord']
endif
fallback = get(g:, 'colorscheme_fallback', fallback)

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
