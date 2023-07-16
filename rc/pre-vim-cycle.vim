" Plugin: bootleq/vim-cycle

let g:cycle_default_groups = [
      \ [['true', 'false']],
      \ [['yes', 'no']],
      \ [['and', 'or']],
      \ [['on', 'off']],
      \ [['>', '<']],
      \ [['==', '!=']],
      \ [['是', '否']],
      \ [['有', '无']],
      \ [["in", "out"]],
      \ [["min", "max"]],
      \ [["get", "post"]],
      \ [["to", "from"]],
      \ [["read", "write"]],
      \ [['with', 'without']],
      \ [["exclude", "include"]],
      \ [["asc", "desc"]],
      \ [["next", "prev"]],
      \ [["encode", "decode"]],
      \ [["left", "right"]],
      \ [["hide", "show"]],
      \ [['「:」', '『:』'], 'sub_pairs'],
      \ [['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday',
      \ 'Friday', 'Saturday'], 'hard_case', {'name': 'Days'}],
      \ [["enable", "disable"]],
      \ [["add", "remove"]],
      \ [['up', 'down']],
      \ [['after', 'before']],
      \ ]
let g:cycle_no_mappings = 1

function! s:trycycle(dir)
  let pat = ben#get_pattern_at_cursor('[+-]\?\d\+')
  if pat
    if a:dir ==? 'x'
      return "\<C-X>"
    else
      return "\<C-A>"
    end
  else
    let mode = mode() =~ 'n' ? 'w' : 'v'
    let dir = a:dir ==? 'x' ? -1 : 1
    return ":\<C-U>call Cycle('" . mode . "', " . dir . ", v:count1)\<CR>"
  end
endfunction

nnoremap <expr> <silent> <C-X> <SID>trycycle('x')
vnoremap <expr> <silent> <C-X> <SID>trycycle('x')
nnoremap <expr> <silent> <C-A> <SID>trycycle('p')
vnoremap <expr> <silent> <C-A> <SID>trycycle('p')
nnoremap <Plug>CycleFallbackNext <C-A>
nnoremap <Plug>CycleFallbackPrev <C-X>

