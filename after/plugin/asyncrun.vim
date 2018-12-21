" Plugin: skywind3000/asyncrun.vim
if !ben#has_plugin('asyncrun.vim')
  finish
endif

command! -bang -nargs=* -complete=file -bar Make  AsyncRun<bang> -save=1 -program=make -auto=make @ <args>

augroup asyncrun_config
  au!
  au User AsyncRunStop copen | wincmd p
  au User AsyncRunPre cclose
augroup END

" let g:proxy_command = 'proxychains -q'
let s:proxy_command = get(g:, 'proxy_command', '')
exe 'nmap <leader>oy :<C-U>AsyncRun '. s:proxy_command . ' ydcv <cword><CR>'

nmap <leader>; :AsyncRun<space>
map <F8>    :Make<CR>
