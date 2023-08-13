vim9script
if has('win32')
    g:terminal_shell = 'pwsh'
else
    g:terminal_shell = &shell
endif

g:terminal_cwd = 2
g:terminal_list = 0
g:terminal_close = 1
g:terminal_pos = "rightbelow"
g:terminal_height = 10
g:terminal_cd = 'cd'

nnoremap <silent> <leader>ot :call TerminalToggle()<CR>

const repeat_last = has('win32') ? "Invoke-History -id (Get-History | Select-Object -Last 1).id" : "!!"
command! -nargs=0 HRepeat execute($"H {repeat_last}")
noremap <F4>      :<C-u>HRepeat<CR>
inoremap <F4> <ESC>:HRepeat<CR>

def Hv()
  const sv_pos = g:terminal_pos
  const sv_height = g:terminal_height
  g:terminal_pos = 'vertical'
  g:terminal_height = ''
  execute('H')
  g:terminal_pos = sv_pos
  g:terminal_height = sv_height
enddef

command! -nargs=0 Hv Hv()
