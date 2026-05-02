vim9script

def SrtText()
  const lines = getline(0, '$')
  var output_lines = []
  var time = ''

  var state = 'no.'
  for line in lines
    if line->trim() == ''
      continue
    endif

    if state == 'no.' && line =~ '^\d\+$'
      state = 'timestamp'
    elseif state == 'timestamp' && line =~ '^\d'
      state = 'text'
      time = line[ : line->stridx('-->')]
    else
      output_lines->add(time .. line)
      state = 'no.'
    endif
  endfor

  const bufname = 'srttext://' .. expand('%:t:r')
  enew
  execute $'silent! keepalt file {bufname->escape('#%')}'
  setlocal nospell
  setlocal buftype=nofile
  setlocal bufhidden=wipe
  # setlocal bufhidden=hide
  setlocal nobuflisted
  setlocal noswapfile
  setlocal nolist
  append(0, output_lines)
enddef

command! -buffer -nargs=0 SrtText call SrtText()
