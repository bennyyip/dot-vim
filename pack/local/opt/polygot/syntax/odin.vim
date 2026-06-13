syntax match odinTodo "NOTE" contained
syntax match odinProcedure "\v<\w*>(\s*:\s*:\s*(#.*\s*)?proc)@=" display

syntax match odinProcCall "\v\w+\s*(\()@=" display
highlight link odinProcCall Function

highlight link odinAddressOf Operator
highlight link odinDeref Operator

syntax keyword odinType cstring16 string16
