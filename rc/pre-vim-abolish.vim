vim9script

def Ada_Case(word: string): string
  var result = word
  result = substitute(result, '::', '/', 'g')
  result = substitute(result, '\(\u\+\)\(\u\l\)', '\1_\2', 'g')
  result = substitute(result, '\(\l\|\d\)\(\u\)', '\1_\2', 'g')
  result = substitute(result, '[.-]', '_', 'g')
  result = substitute(result, '_\zs\l', '\u&', 'g')
  result = substitute(result, '^.', '\u&', '')
  return result
enddef

g:Abolish = {
  'adacase': function(Ada_Case),
  'Coercions': {
    'a': function(Ada_Case),
  },
}
