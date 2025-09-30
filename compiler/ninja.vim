if exists("current_compiler")
    finish
endif
let current_compiler = "ninja"

if !exists("g:ninja_target")
    let g:ninja_target = ""
endif

CompilerSet errorformat&
execute 'CompilerSet makeprg=ninja\ -C\ build\ ' . g:ninja_target
