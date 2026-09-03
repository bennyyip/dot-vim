syntax keyword odinType byte

syntax match odinTodo "NOTE" contained

syntax match odinProcCall "\v\w+\s*(\()@=" display
highlight link odinProcCall Function

syntax match odinOr "||" display
highlight link odinAddressOf Operator
highlight link odinOr Operator
highlight link odinDeref Operator

syntax keyword odinType cstring16 string16
