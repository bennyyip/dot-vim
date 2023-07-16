" Apprence [[[1
let s:is_ssh = ($SSH_CONNECTION != "")
let s:is_gvim = has('gui_running')
let s:is_tty = !match(&term, 'linux')
" Color Scheme [[[3
set background=dark
colorscheme gruvbox8
let g:gruvbox_material_background = 'hard'
let g:gruvbox_plugin_hi_groups = 1
let g:gruvbox_filetype_hi_groups = 1
if s:is_gvim
  let g:gruvbox_italic = 1
  let g:gruvbox_italicize_strings = 1
else
  let g:gruvbox_italic = 0
  let g:gruvbox_italicize_strings = 0
endif
let s:colorscheme = get(g:, 'colors_name', 'default')
" Plugin: itchyny/lightline.vim [[[3
" g:lightline[[[4
let g:lightline = {
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left':  [ [ 'mode', 'paste' ], [ 'fugitive', 'filename'] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'cocstatus', 'asyncrun', 'fileformat', 'fileencoding', 'filetype'] ]
      \ },
      \ 'inactive': {
      \ 'left': [ [ 'filename' ] ],
      \ 'right': [ [ 'lineinfo' ],
      \            [ 'percent' ] ],
      \ },
      \ 'component_function': {
      \   'modified':     'LightlineModified',
      \   'readonly':     'LightlineReadonly',
      \   'fugitive':     'LightlineFugitive',
      \   'filename':     'LightlineFilename',
      \   'fileformat':   'LightlineFileformat',
      \   'filetype':     'LightlineFiletype',
      \   'fileencoding': 'LightlineFileencoding',
      \   'mode':         'LightlineMode',
      \   'asyncrun':     'LightlineAsyncrun',
      \   'cocstatus':    'coc#status',
      \ },
      \ }

autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

if !s:is_tty
  let g:lightline.colorscheme = 'gruvbox8'
  " let g:lightline.separator = { 'left': "", 'right': "\ue0be" }
  " let g:lightline.subseparator = { 'left': "", 'right': "\ue0b9" }
  let g:lightline.separator = { 'left': "\ue0b8", 'right': "\ue0be" }
  let g:lightline.subseparator = { 'left': "\ue0b9", 'right': "\ue0b9" }
  " let g:lightline.tabline_separator = { 'left': "", 'right': "\ue0be" }
  " let g:lightline.tabline_subseparator = { 'left': "", 'right': "\ue0b9" }
  let g:lightline.tabline_separator = { 'left': "\ue0b8", 'right': "\ue0be" }
  let g:lightline.tabline_subseparator = { 'left': "\ue0b9", 'right': "\ue0b9" }
endif

function LightlineAsyncrun()
  return get(g:, 'asyncrun_status', '')
endfunction

function! LightlineModified() "[[[4
  return &filetype =~# 'help\|vimfiler\|Mundo\|qf' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction
function! LightlineReadonly() "[[[4
  return &filetype !~? 'help\|vimfiler\|Mundo\|qf' && &readonly ? (s:is_tty ? 'RO' : "\ue0a2") : ''
endfunction
function! LightlineFilename() "[[[4
  if &filetype ==# 'qf'
    let wininfo = filter(getwininfo(), {i,v -> v.winnr == winnr()})[0]
    if wininfo.loclist
      return "[Location List]"
    else
      return "[Quickfix List]"
    endif
  endif

  let l:fname = expand('%:~')
  return l:fname ==# '__Tagbar__' ? g:lightline.l:fname :
        \ l:fname =~# '__Mundo\|NERD_tree' ? '' :
        \ &filetype ==# 'vimfiler' ? vimfiler#get_status_string() :
        \ &filetype ==# 'denite' ? denite#get_status_sources() :
        \ &filetype ==# 'vimshell' ? vimshell#get_status_string() :
        \ ('' !=# LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ ('' !=# l:fname ? l:fname : '[No Name]') .
        \ ('' !=# LightlineModified() ? ' ' . LightlineModified() : '')
endfunction
function! LightlineFugitive() "[[[4
  try
    if expand('%:t') !~? 'Tagbar\|Mundo\|NERD' && &filetype !~? 'vimfiler' && exists('*fugitive#head')
      let l:mark = ''  " edit here for cool mark
      let l:branch = fugitive#head()
      return l:branch !=# '' ? (s:is_tty ? '' : "\ue0a0 ").l:branch : ''
    endif
  catch
  endtry
  return ''
endfunction
function! LightlineFileformat() "[[[4
  return winwidth(0) > 70 ? &fileformat : ''
endfunction
function! LightlineFiletype() "[[[4
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction
function! LightlineFileencoding() "[[[4
  return winwidth(0) > 70 ? (&fileencoding !=# '' ? &fileencoding : &encoding) : ''
endfunction
function! LightlineMode() "[[[4
  let l:fname = expand('%:t')
  return l:fname ==# '__Tagbar__' ? 'Tagbar' :
        \ l:fname =~# 'NERD_tree' ? 'NERDTree' :
        \ &filetype ==# 'denite' ? 'Denite' :
        \ &filetype ==# 'vimfiler' ? 'VimFiler' :
        \ &filetype ==# 'vimshell' ? 'VimShell' :
        \ lightline#mode()[0]
        "\ winwidth(0) > 60 ? lightline#mode() : ''
endfunction
" other [[[3
" terminal true color
if !s:is_ssh && has("termguicolors")
  " fix bug for vim
  set t_8f=[38;2;%lu;%lu;%lum
  set t_8b=[48;2;%lu;%lu;%lum

  " enable true color
  set termguicolors
endif


" vim:fdm=marker:fmr=[[[,]]]:ft=vim
