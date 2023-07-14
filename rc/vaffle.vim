" Plugin: cocopon/vaffle.vim

nmap -  :<C-u>Vaffle %:p<CR>

function! s:customize_vaffle_mappings() abort
  " Customize key mappings here
  nmap <buffer> - <Plug>(vaffle-open-parent)
endfunction

augroup vimrc_vaffle
  autocmd!
  autocmd FileType vaffle call s:customize_vaffle_mappings()
augroup END
