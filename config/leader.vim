"nnoremap <silent> <leader><tab> :cal SwitchBuffer()<CR>
nnoremap <leader><tab> :CtrlPMRUFiles<CR>
nnoremap <leader>feR <Esc>:so ~/.vim/init.vim<CR>
nnoremap <leader>fed <Esc>:e ~/.vim/init.vim<CR>
nnoremap <leader>ff :CtrlP<CR>
nnoremap <leader>fr :CtrlPMRUFiles<CR>
nnoremap <leader>fs :w<CR>
nnoremap <leader>qQ :q!<CR>
nnoremap <leader>qq :q<CR>

nnoremap <leader>oy :<C-u>Dic<CR>

let s:switch_buffer_flag=1

fu! g:SwitchBuffer()
  if s:switch_buffer_flag==1
    execute ":bn"
    let s:switch_buffer_flag=0
  else
    execute ":bp"
    let s:switch_buffer_flag=1
  endif
endfunction
  


