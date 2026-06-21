vim9script

export def Filename(template: string = '$1', fallback: string = '' ): string
  const basename = expand('%:t:r')

  if basename == ''
    return fallback
  else
    return substitute(template, '$1', basename, 'g')
  endif
enddef

export def IncrCounter(): string
  var counter = get(b:, 'ben_counter', 0)
  counter += 1
  b:ben_counter = counter
  return string(counter)
enddef
