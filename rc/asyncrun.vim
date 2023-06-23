" Plugin: skywind3000/asyncrun.vim

let g:asyncrun_save = 1

augroup asyncrun_config
  au!
  au User AsyncRunStop copen | wincmd p
  au User AsyncRunPre cclose
augroup END

command! -bang -nargs=* -complete=file -bar Make  AsyncRun<bang> -save=1 -program=make -auto=make @ <args>

command! -bang -nargs=* Rg     call s:rg(0, 0, <q-args>)
command! -bang -nargs=* Rgr    call s:rg(1, 0, <q-args>)
command! -bang -nargs=* Rgadd  call s:rg(0, 1, <q-args>)
command! -bang -nargs=* Rgradd call s:rg(1, 1, <q-args>)

function! s:rg(root, append, args, ...)
  " avoid some plugin modify errorformat
  let g:ben_old_efm = &efm
  set efm=%f:%\\s%#%l:%c:%m

  let l:cmd =  "AsyncRun! -strip -post=let\\ &efm=g:ben_old_efm "

  if a:root != 0
    let l:path = asyncrun#get_root('%')
  else
    let l:path = expand('%:h:p')
  endif

  if l:path == ""
    let l:path = "."
  endif

  if a:append != 0
    let l:cmd .= "-append "
  endif


  let l:cmd .= "@ rg -S --vimgrep " . fnameescape(a:args) . ' ' . shellescape(l:path)
  execute l:cmd
endfunction


noremap <leader>; :AsyncRun<space>
noremap <leader>: :AsyncStop<CR>
noremap <F8>      :Make<CR>

noremap <silent> <leader>q :<C-u>call asyncrun#quickfix_toggle(8)<CR>

if has('win32')
let g:asyncrun_wrapper = 'powershell -NoProfile -Command'
  nmap <leader>ii :AsyncRun Invoke-Item '$(VIM_FILEDIR)'<CR>
  nmap <leader>ps :AsyncRun wt new-tab -d '$(VIM_FILEDIR)'<CR>
endif