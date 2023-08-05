vim9script
# Plugin: Yggdroot/LeaderF

if executable('rg')
  g:Lf_DefaultExternalTool = 'rg'
endif
g:Lf_StlColorscheme = 'gruvbox_material'

g:Lf_ShortcutF = ''
g:Lf_ShortcutB = ''
g:Lf_MruMaxFiles = 500
g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2"}
g:Lf_HideHelp = 1
g:Lf_ShowRelativePath = 1
g:Lf_JumpToExistingWindow = 0
g:Lf_CommandMap = {'<ESC>': ['<ESC>', '<C-G>'], '<C-j>': ['<C-j>', '<C-n>'], '<C-k>': ['<C-k>', '<C-p>']}
g:Lf_NormalMap = {
      \ "File":   [["<ESC>", ':exec g:Lf_py "fileExplManager.quit()"<CR>']],
      \ "Buffer": [["<ESC>", ':exec g:Lf_py "bufExplManager.quit()"<CR>']],
      \ "Mru":    [["<ESC>", ':exec g:Lf_py "mruExplManager.quit()"<CR>']],
      \ "Tag":    [["<ESC>", ':exec g:Lf_py "tagExplManager.quit()"<CR>']],
      \ "Function":    [["<ESC>", ':exec g:Lf_py "functionExplManager.quit()"<CR>']],
      \ "Colorscheme":    [["<ESC>", ':exec g:Lf_py "colorschemeExplManager.quit()"<CR>']],
      \ }

g:Lf_PreviewResult = {
      \ 'File': 0,
      \ 'Buffer': 0,
      \ 'Mru': 0,
      \ 'Tag': 0,
      \ 'BufTag': 1,
      \ 'Function': 1,
      \ 'Line': 1,
      \ 'Colorscheme': 0,
      \ 'Rg': 0,
      \ 'Gtags': 0
      \}


def SearchHere()
  const sv = get(g:, 'Lf_WorkingDirectoryMode', 'c')
  g:Lf_WorkingDirectoryMode = 'f'
  execute 'LeaderfFile'
  g:Lf_WorkingDirectoryMode = sv
enddef

def SearchProject()
  const sv = get(g:, 'Lf_WorkingDirectoryMode', 'c')
  g:Lf_WorkingDirectoryMode = 'A'
  execute 'LeaderfFile'
  g:Lf_WorkingDirectoryMode = sv
enddef


nnoremap <leader>.  :call <SID>SearchHere()<CR>
nnoremap <leader>b  :Leaderf buffer <CR>
nnoremap <leader>ff :Leaderf file <CR>
nnoremap <leader>fp :execute('Leaderf file ' .. expand("$v"))<CR>
nnoremap <leader>fq :Leaderf ghq --popup<CR>
nnoremap <leader>fr :Leaderf mru <CR>
nnoremap <leader>pf  :call <SID>SearchProject()<CR>
nnoremap gb  :Leaderf buffer <CR>
nnoremap gr  :<C-U>Leaderf rg -e<Space>

command! -bar -bang -nargs=0 Rg call <SID>Rg(<bang>0)
command! -bar -nargs=? History call <SID>History(<q-args>)
command! -bar -nargs=0 BLines Leaderf line --all
command! -bar -nargs=0 Buffers Leaderf buffer
command! -bar -nargs=0 BuffersAll Leaderf buffer --all
command! -bar -nargs=0 Commands Leaderf command
command! -bar -nargs=0 FileTypes Leaderf filetype
command! -bar -nargs=0 Lines Leaderf line

def History(arg: string)
  if arg[0] == ':'
    Leaderf cmdHistory
  elseif arg[0] == '/'
    exec "Leaderf searchHistory" | silent! norm! n
  else
    Leaderf mru
  endif
enddef

def Rg(bang: any)
  if bang
    exec "Leaderf! rg --recall"
  else
    call leaderf#Rg#Interactive()
  endif
enddef
