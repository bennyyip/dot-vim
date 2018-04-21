setlocal commentstring=(*%s*)
nmap <LocalLeader>r  <Plug>(MerlinRename)
nmap <LocalLeader>R  <Plug>(MerlinRenameAppend)
nmap <LocalLeader>*  <Plug>(MerlinSearchOccurrencesForward)
nmap <LocalLeader>#  <Plug>(MerlinSearchOccurrencesBackward)

let g:completor_ocaml_omni_trigger = '[^. *\t]\.\w*\|\h\w*|#'

