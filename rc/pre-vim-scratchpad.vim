vim9script

g:scratchpad_path = $VIMSTATE .. ".scratchpads"

nmap <silent> <leader>x <Plug>(ToggleScratchPad)
command -nargs=1 Scratchpad call scratchpad#ToggleScratchPad(<q-args>)
