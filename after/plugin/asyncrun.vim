" Plugin: skywind3000/asyncrun.vim
if !ben#has_plugin('asyncrun.vim')
  finish
endif


augroup asyncrun_config
  au!
  au User AsyncRunStop copen | wincmd p
  au User AsyncRunPre cclose
augroup END

command! -bang -nargs=* -complete=file -bar Make  AsyncRun<bang> -save=1 -program=make -auto=make @ <args>

command! -bang -nargs=* Rg    AsyncRun<bang> -strip         @ rg -S --vimgrep <args>
command! -bang -nargs=* Rgadd AsyncRun<bang> -strip -append @ rg -S --vimgrep <args>
command! -bang -nargs=* Rgr    AsyncRun<bang> -strip -cwd=<root> @ rg -S --vimgrep <args>
command! -bang -nargs=* Rgradd AsyncRun<bang> -strip -append -cwd=<root> @ rg -S --vimgrep <args>


" let g:proxy_command = 'proxychains -q'
let s:proxy_command = get(g:, 'proxy_command', '')
exe 'nmap gY :<C-U>AsyncRun '. s:proxy_command . ' ydcv <cword><CR>'

noremap <leader>; :AsyncRun<space>
noremap <leader>: :AsyncStop<CR>
noremap <F8>      :Make<CR>

noremap <silent> <leader>q :<C-u>call asyncrun#quickfix_toggle(8)<CR>
