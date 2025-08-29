function! lightline#colorscheme#flatten(p) abort
  for k in values(a:p)
    for l in values(k)
      for m in range(len(l))
        let attr = ''
        if len(l[m]) == 3 && type(l[m][2]) == 1
          let attr = l[m][2]
        endif
        let l[m] = [l[m][0][0], l[m][1][0], l[m][0][1], l[m][1][1]]
        if !empty(attr)
          call add(l[m], attr)
        endif
      endfor
    endfor
  endfor
  return a:p
endfunction

if has('gui_running') || (has('termguicolors') && &termguicolors)
  function! lightline#colorscheme#background() abort
    return &background
  endfunction
else
  " &background is set inappropriately when the colorscheme sets ctermbg of the Normal group
  function! lightline#colorscheme#background() abort
    let bg_color = synIDattr(synIDtrans(hlID('Normal')), 'bg', 'cterm')
    if bg_color !=# ''
      if bg_color < 16
        return &background
      elseif 232 <= bg_color && bg_color < 244
        return 'dark'
      elseif 244 <= bg_color
        return 'light'
      endif
    endif
    let fg_color = synIDattr(synIDtrans(hlID('Normal')), 'fg', 'cterm')
    if fg_color !=# ''
      if fg_color < 7 || 232 <= fg_color && fg_color < 244
        return 'light'
      elseif 8 <= fg_color && fg_color < 16 || 244 <= fg_color
        return 'dark'
      endif
    endif
    return &background
  endfunction
endif

