vim9script

var orig_guifont: string = &guifont
var orig_guifontwide: string = &guifontwide

if empty(orig_guifont)
  if has("win32")
    orig_guifont = 'Consolas:h12'
  else
    orig_guifont = 'Monospace 12'
  endif
  &guifont = orig_guifont
endif

def GetFontParams(font: string): list<any>
  var params: list<string>
  if has("win32")
    params = matchlist(font, '\v(.{-}):h(\d+(\.\d+)?)')
  else
    params = matchlist(font, '\v(.{-}) (\d+(\.\d+)?)$')
  endif
  return [params[1], str2nr(params[2])]
enddef


def Change_(op: string, f: string)
enddef

export def Change(op: string, cnt: number = 1)
  if op == 'restore'
    exe printf('&guifont = "%s"', orig_guifont)
    exe printf('&guifontwide = "%s"', orig_guifontwide)
    wincmd =
    return
  endif

  for f in ['guifont', 'guifontwide']
    var cur_fonts = getwinvar(0, '&' .. f)->split(",")

    var new_fonts = []

    for font in cur_fonts
      var [fontname, fontsize] = GetFontParams(font)

      if (fontsize < 8 && op == 'dec') || (fontsize > 64 && op == 'inc')
        return
      endif

      if op == 'inc'
        new_fonts->add(fontname .. (has("win32") ? ':h' : ' ') .. (fontsize + cnt * 2))
      elseif op == 'dec'
        new_fonts->add(fontname .. (has("win32") ? ':h' : ' ') .. (fontsize - cnt * 2))
      endif
    endfor

    exec printf('set %s=%s', f, escape(new_fonts->join(','), ' '))
  endfor
  wincmd =
enddef
