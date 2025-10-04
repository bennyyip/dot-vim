vim9script
compiler shellcheck
setlocal makeprg=shellcheck\ -s\ busybox\ -f\ gcc\ %
