" Plugin: Yggdroot/LeaderF

if executable('rg')
  let g:Lf_DefaultExternalTool = 'rg'
endif
let g:Lf_ShortcutF=''
let g:Lf_ShortcutB=''
let g:Lf_MruMaxFiles=500
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2"}
let g:Lf_HideHelp = 1
let g:Lf_ShowRelativePath = 1
let g:Lf_JumpToExistingWindow = 0
let g:Lf_CommandMap = {'<ESC>': ['<ESC>', '<C-G>']}
let g:Lf_NormalMap = {
      \ "File":   [["<ESC>", ':exec g:Lf_py "fileExplManager.quit()"<CR>']],
      \ "Buffer": [["<ESC>", ':exec g:Lf_py "bufExplManager.quit()"<CR>']],
      \ "Mru":    [["<ESC>", ':exec g:Lf_py "mruExplManager.quit()"<CR>']],
      \ "Tag":    [["<ESC>", ':exec g:Lf_py "tagExplManager.quit()"<CR>']],
      \ "Function":    [["<ESC>", ':exec g:Lf_py "functionExplManager.quit()"<CR>']],
      \ "Colorscheme":    [["<ESC>", ':exec g:Lf_py "colorschemeExplManager.quit()"<CR>']],
      \ }

let g:Lf_PreviewResult = {
      \ 'File': 0,
      \ 'Buffer': 0,
      \ 'Mru': 0,
      \ 'Tag': 0,
      \ 'BufTag': 1,
      \ 'Function': 1,
      \ 'Line': 0,
      \ 'Colorscheme': 0,
      \ 'Rg': 0,
      \ 'Gtags': 0
      \}


function! s:search_here() abort
  let l:sv = get(g:, 'Lf_WorkingDirectoryMode', 'c')
  let g:Lf_WorkingDirectoryMode = 'f'
  execute 'LeaderfFile'
  let g:Lf_WorkingDirectoryMode = l:sv
endfunction

function! s:search_project() abort
  let l:sv = get(g:, 'Lf_WorkingDirectoryMode', 'c')
  let g:Lf_WorkingDirectoryMode = 'A'
  execute 'LeaderfFile'
  let g:Lf_WorkingDirectoryMode = l:sv
endfunction


nnoremap <leader>.  :call <SID>search_here()<CR>
nnoremap <leader>b  :Leaderf buffer <CR>
nnoremap <leader>ff :Leaderf file <CR>
nnoremap <leader>fp :LeaderfFile $v<CR>
nnoremap <leader>fq :Leaderf ghq --popup<CR>
nnoremap <leader>fr :Leaderf mru <CR>
nnoremap <leader>gt :LeaderfBufTag<CR>
nnoremap <leader>pf  :call <SID>search_project()<CR>
nnoremap <leader>si :Leaderf function<CR>
nnoremap gb  :Leaderf buffer <CR>
nnoremap gr  :<C-U>Leaderf rg -e<Space>

command! -bar -bang -nargs=0 Rg call s:rg(<bang>0)
command! -bar -nargs=* History call s:history(<q-args>)
command! -bar -nargs=0 BLines Leaderf line --all
command! -bar -nargs=0 Buffers Leaderf buffer
command! -bar -nargs=0 BuffersAll Leaderf buffer --all
command! -bar -nargs=0 Commands Leaderf command
command! -bar -nargs=0 FileTypes Leaderf filetype
command! -bar -nargs=0 Lines Leaderf line

function! s:history(arg)
  if a:arg[0] == ':'
    Leaderf cmdHistory
  elseif a:arg[0] == '/'
    exec "Leaderf searchHistory" | silent! norm! n
  else
    Leaderf mru
  endif
endfunction

function! s:rg(bang)
  if a:bang
    exec "Leaderf! rg --recall"
  else
    call leaderf#Rg#Interactive()
  endif
endfunction
