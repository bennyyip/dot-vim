" Plugin: cocopon/vaffle.vim

nmap -  :<C-u>Vaffle %:p<CR>

function! s:customize_vaffle_mappings() abort
  " Customize key mappings here
  nmap <buffer> - <Plug>(vaffle-open-parent)
  nmap <buffer> <Bslash> <Plug>(vaffle-open-root)

endfunction

augroup vimrc
  autocmd!
  autocmd FileType vaffle call s:customize_vaffle_mappings()
augroup END
