vim9script

export def Filename(template: string = '$1', fallback: string = '' ): string
  const basename = expand('%:t:r')

  if basename == ''
    return fallback
  else
    return substitute(template, '$1', basename, 'g')
  endif
enddef

