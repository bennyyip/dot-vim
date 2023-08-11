vim9script
# Plugin: cocopon/vaffle.vim

nmap -  :<C-u>Vaffle %:p:h<CR>

def CustomizeVaffleMappings()
  # Customize key mappings here
  nmap <buffer> - <Plug>(vaffle-open-parent)
  nmap <buffer> + <Plug>(vaffle-mkdir)
  nmap <buffer> g? :help vaffle-default-key-mappings<CR>
enddef

augroup vimrc
  autocmd FileType vaffle CustomizeVaffleMappings()
augroup END
