vim9script
# Plugin: cocopon/vaffle.vim

nmap -  :<C-u>Vaffle %:p<CR>

def CustomizeVaffleMappings()
  # Customize key mappings here
  nmap <buffer> - <Plug>(vaffle-open-parent)
  nmap <buffer> <Bslash> <Plug>(vaffle-open-root)

enddef

augroup vimrc
  autocmd FileType vaffle call CustomizeVaffleMappings()
augroup END
