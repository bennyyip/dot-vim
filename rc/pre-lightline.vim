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

if plugpac#HasPlugin("lightline-ale")
  let g:lightline.component_expand = {
        \  'linter_checking': 'lightline#ale#checking',
        \  'linter_infos': 'lightline#ale#infos',
        \  'linter_warnings': 'lightline#ale#warnings',
        \  'linter_errors': 'lightline#ale#errors',
        \  'linter_ok': 'lightline#ale#ok',
        \ }
  let g:lightline.component_type = {
        \     'linter_checking': 'right',
        \     'linter_infos': 'right',
        \     'linter_warnings': 'warning',
        \     'linter_errors': 'error',
        \     'linter_ok': 'right',
        \ }

  let g:lightline.active.right = [
        \  [  'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok', 'lineinfo', ],
        \  [ 'percent' ],
        \  [ 'cocstatus', 'asyncrun', 'fileformat', 'fileencoding', 'filetype' ] ]

  let g:lightline#ale#indicator_checking = "\uf110"
  " let g:lightline#ale#indicator_infos = "\uf129"
  " let g:lightline#ale#indicator_warnings = "\uf071"
  " let g:lightline#ale#indicator_errors = "\uf05e"
  let g:lightline#ale#indicator_ok = "\uf00c"
endif


autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" let s:enable_nerd_font = !s:is_tty && !has('gui_running')
let s:enable_nerd_font = v:false
let g:lightline.colorscheme = 'gruvbox8'

if s:enable_nerd_font
  let g:lightline.separator = { 'left': "\ue0b8", 'right': "\ue0be" }
  let g:lightline.subseparator = { 'left': "\ue0b9", 'right': "\ue0b9" }
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

  let l:fname = winwidth(0) > 70 ? expand('%:~') : expand('%:t')
  let ret = ('' !=# LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ ('' !=# l:fname ? l:fname : '[No Name]') .
        \ ('' !=# LightlineModified() ? ' ' . LightlineModified() : '')
  return ret->substitute('\\', '/', 'g')
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
