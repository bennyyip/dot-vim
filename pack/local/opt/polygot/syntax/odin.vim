syntax match odinTodo "NOTE" contained
syntax match odinEscape display contained /\\\([abefnrtv\\'"]\|\o\{3}\|x\x\{2}\|u\x\{4}\|U\x\{8}\)/

syntax match odinProcCall "\v\w+\s*(\()@=" display
highlight link odinProcCall Function

highlight link odinAddressOf Operator
highlight link odinDeref Operator
