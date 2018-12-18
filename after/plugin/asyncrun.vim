" Plugin: skywind3000/asyncrun.vim
if !ben#has_plugin('asyncrun.vim')
  finish
endif

command! -bang -nargs=* -complete=file -bar Make  AsyncRun<bang> -save=1 -program=make -auto=make @ <args>

augroup vimrc
  " open quickfix when task is done
  autocmd User AsyncRunStop call asyncrun#quickfix_toggle(8, 1)
augroup END
