vim9script

g:termdebug_config = {
  wide: 1,
  evaluate_in_popup: true,
  map_minus: false,
  map_plus: false,
  winbar: false,
}

var saved_mappings = {}
const n_keys = ['<F5>', '<F9>', '<F10>', '<F11>', '<F12>', '<PageUp>', '<PageDown>']

au User TermdebugStartPost {
  for k in n_keys
    saved_mappings[k] = maparg(k, 'n', false, true)
  endfor

  nnoremap <F5>             <CMD>RunOrContinue<CR>
  nnoremap <F9>             <CMD>ToggleBreak<CR>
  nnoremap <F10>            <CMD>Over<CR>
  nnoremap <F11>            <CMD>Step<CR>
  nnoremap <F12>            <CMD>Finish<CR>
  nnoremap <expr><PageUp>   $'<Cmd>{v:count1}Up<CR>'
  nnoremap <expr><PageDown> $'<Cmd>{v:count1}Down<CR>'
}

au User TermdebugStopPost {
  for k in n_keys
    const map = saved_mappings[k]
    if !empty(map) # && !map.buffer
      mapset(map)
    elseif empty(map)
      execute $"silent! nunmap {k}"
    endif
  endfor
}

