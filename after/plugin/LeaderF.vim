" Plugin: Yggdroot/LeaderF
if !plugpac#has_plugin('LeaderF')
  finish
endif
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


nnoremap <leader>ff :Leaderf file <CR>
nnoremap <leader>fp :LeaderfFile $v<CR>
nnoremap <leader>.  :call <SID>search_here()<CR>
nnoremap <leader>pf  :call <SID>search_project()<CR>
nnoremap <leader>fr :Leaderf mru <CR>
nnoremap <leader>b  :Leaderf buffer <CR>
nnoremap <leader>gt :LeaderfBufTag<CR>
nnoremap <leader>fq :Leaderf ghq --popup<CR>
nnoremap gb  :Leaderf buffer <CR>

if plugpac#has_plugin('LeaderF-github-stars')
  nnoremap <leader>gs :Leaderf stars <CR>
endif

if plugpac#has_plugin('LeaderF-ghq')
  nnoremap <leader>gr :Leaderf ghq <CR>
endif

" nnoremap <leader>ff :Leaderf file --popup<CR>
" nnoremap <leader>fr :Leaderf mru --popup<CR>
" nnoremap <leader>b  :Leaderf buffer --popup<CR>
" nnoremap <leader>gt :LeaderfBufTag<CR>
" nnoremap gb  :Leaderf buffer --popup<CR>
"
" if plugpac#has_plugin('LeaderF-github-stars')
"   nnoremap <leader>gs :Leaderf stars --popup<CR>
" endif
"
" if plugpac#has_plugin('LeaderF-ghq')
"   nnoremap <leader>gr :Leaderf ghq --popup<CR>
" endif
