" Plugin: cocopon/vaffle.vim
if !plugpac#has_plugin('vaffle.vim')
  finish
endif

nmap -  :<C-u>Vaffle<CR>

function! s:customize_vaffle_mappings() abort
  " Customize key mappings here
  nmap <buffer> - <Plug>(vaffle-open-parent)
endfunction

augroup vimrc_vaffle
  autocmd!
  autocmd FileType vaffle call s:customize_vaffle_mappings()
augroup END
