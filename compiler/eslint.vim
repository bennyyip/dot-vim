if exists("current_compiler")
  finish
endif
let current_compiler = "eslint"

CompilerSet makeprg=pnpm\ eslint\ --no-color\ -f\ compact\ $*

CompilerSet errorformat=%f:\ line\ %l\\,\ col\ %c\\,\ %trror\ -\ %m,
											 \%f:\ line\ %l\\,\ col\ %c\\,\ %tarning\ -\ %m,
											 \%-G%.%#
