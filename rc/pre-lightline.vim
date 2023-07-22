" Plugin: itchyny/lightline.vim [[[1
let s:is_tty = !match(&term, 'linux')
let g:lightline = {
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

function LightlineAsyncrun() "[[[2
  return get(g:, 'asyncrun_status', '')
endfunction

function! LightlineModified() "[[[2
  return &filetype =~# 'help\|vaffle\|undotree\|qf' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction
function! LightlineReadonly() "[[[2
  return &filetype !~? 'help\|vaffle\|undotree\|qf' && &readonly ? (s:is_tty ? 'RO' : "\ue0a2") : ''
endfunction
function! LightlineFilename() "[[[2
  if &filetype ==# 'qf'
    let wininfo = filter(getwininfo(), {i,v -> v.winnr == winnr()})[0]
    if wininfo.loclist
      return "[Location List]"
    else
      return "[Quickfix List]"
    endif
  endif

  let l:fname = expand('%:~')
  return ('' !=# LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ ('' !=# l:fname ? l:fname : '[No Name]') .
        \ ('' !=# LightlineModified() ? ' ' . LightlineModified() : '')
endfunction
function! LightlineFugitive() "[[[2
  try
    if expand('%:t') !~? 'undotree\|diffpanel' && &filetype !~? 'vaffle'
      let l:mark = (s:is_tty ? '' : "\ue0a0 ")
      let l:branch = fugitive#Head()
      return l:branch !=# '' ? l:mark .. l:branch : ''
    endif
  catch
  endtry
  return ''
endfunction
function! LightlineFileformat() "[[[2
  return winwidth(0) > 70 ? &fileformat : ''
endfunction
function! LightlineFiletype() "[[[2
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction
function! LightlineFileencoding() "[[[2
  return winwidth(0) > 70 ? (&fileencoding !=# '' ? &fileencoding : &encoding) : ''
endfunction
function! LightlineMode() "[[[2
  " let l:fname = expand('%:~')
  return &filetype =~# 'vaffle\|undotree' ? 'P' :
        \ lightline#mode()[0]
endfunction

" vim:fdm=marker:fmr=[[[,]]]:ft=vim
