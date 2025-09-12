vim9script

g:termdebug_config = {
  wide: 1,
  evaluate_in_popup: true,
  map_minus: false,
  map_plus: false,
  # signs: ['>1', '>2', '>3', '>4', '>5', '>6', '>7', '>8', '>9', '>A', '>B', '>C', '>D', '>E', '>F'],
  # sign: '>>',
}

var saved_mappings = {}
const n_keys = ['<F5>', '<F9>', '<F10>', '<F11>', '<S-F11>', '<PageUp>', '<PageDown>']

au User TermdebugStartPost {
  for k in n_keys
    saved_mappings[k] = maparg(k, 'n', false, true)
  endfor

  nnoremap <F5>             <CMD>RunOrContinue<CR>
  # TODO toggle
  nnoremap <F9>             <CMD>Break<CR>
  nnoremap <F10>            <CMD>Over<CR>
  nnoremap <F11>            <CMD>Step<CR>
  nnoremap <S-F11>          <CMD>Finish<CR>
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
