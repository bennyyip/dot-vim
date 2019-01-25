setlocal commentstring=(*%s*)
nmap <buffer><LocalLeader>r  <Plug>(MerlinRename)
nmap <buffer><LocalLeader>R  <Plug>(MerlinRenameAppend)
nmap <buffer><LocalLeader>*  <Plug>(MerlinSearchOccurrencesForward)
nmap <buffer><LocalLeader>#  <Plug>(MerlinSearchOccurrencesBackward)

let g:completor_ocaml_omni_trigger = '[^. *\t]\.\w*\|\h\w*|#'

