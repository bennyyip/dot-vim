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

nnoremap <expr> <silent> <C-X> ben#trycycle('x')
vnoremap <expr> <silent> <C-X> ben#trycycle('x')
nnoremap <expr> <silent> <C-A> ben#trycycle('p')
vnoremap <expr> <silent> <C-A> ben#trycycle('p')
nnoremap <Plug>CycleFallbackNext <C-A>
nnoremap <Plug>CycleFallbackPrev <C-X>

