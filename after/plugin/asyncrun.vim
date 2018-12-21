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
