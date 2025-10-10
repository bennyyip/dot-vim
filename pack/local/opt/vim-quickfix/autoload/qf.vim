vim9script

export def IsLocationList(): bool
    return getloclist(winnr(), {'filewinid': 0}).filewinid > 0
enddef

export def QuickFixText(info: dict<any>): list<string>
    var items = []
    if info.quickfix == 1
        items = getqflist({id: info.id, items: 1}).items
    else
        items = getloclist(info.winid, {id: info.id, items: 1}).items
    endif
    var l = []
    for idx in range(info.start_idx - 1, info.end_idx - 1)
        if items[idx].valid
            var text = fnamemodify(bufname(items[idx].bufnr), ':p:~:.')
            if items[idx].lnum != 0
                text ..= $"|{items[idx].lnum}"
            endif
            if items[idx].col != 0
                text ..= $":{items[idx].col}"
            endif
            text ..= $":{items[idx].text}"
            add(l, text)
        else
            add(l, items[idx].text)
        endif
    endfor
    return l
enddef

export def View()
    var winid = win_getid()
    exe "normal! \<CR>"
    if winid == win_getid()
        return
    endif
    normal! zz
    if exists(":BlinkLine") == 2
        BlinkLine
    endif
    wincmd p
enddef

export def Next()
    try
        if IsLocationList()
            lnext
        else
            cnext
        endif
        if exists(":BlinkLine") == 2
            BlinkLine
        endif
        wincmd p
    catch
    endtry
enddef

export def Prev()
    try
        if IsLocationList()
            lprev
        else
            cprev
        endif
        if exists(":BlinkLine") == 2
            BlinkLine
        endif
        wincmd p
    catch
    endtry
enddef

# Toggle quickfix and loclist
export def ToggleQF()
    if getwininfo()->filter('v:val.quickfix')->len() > 0
        cclose
    else
        botright copen
    endif
enddef

export def ToggleLoc()
    if getwininfo()->filter('v:val.loclist')->len() > 0
        lclose
    else
        botright lopen
    endif
enddef

export def Older()
  History(false)
enddef

export def Newer()
  History(true)
enddef

export def Print()
  const nr = GetProperty('nr')
  const last = GetProperty('nr', '$')
  echohl MoreMsg | echon '('
  echohl Identifier | echon nr
  if last > 1
    echohl LineNr | echon ' of '
    echohl Identifier | echon last
  endif
  echohl MoreMsg | echon ') '
  echohl MoreMsg | echon '['
  echohl Identifier | echon Length()
  echohl MoreMsg | echon '] '
  echohl Normal | echon GetProperty('title')
  echohl None
enddef

def GetProperty(key: string, val: any = 0): any
  const what = { [key]: val }
  const listdict = IsLocationList() ? getloclist(0, what) : getqflist(what)
  return get(listdict, key)
enddef


def Length(): number
  return len(IsLocationList() ? getloclist(0) : getqflist())
enddef

def IsFirst(): bool
  return GetProperty('nr') <= 1
enddef

def IsLast(): bool
  return GetProperty('nr') == GetProperty('nr', '$')
enddef

def History(goNewer: bool)
  const cmd = (IsLocationList() ? 'l' : 'c') .. (goNewer ? 'newer' : 'older')
  while true
    if (goNewer && IsLast()) || (!goNewer && IsFirst())
      break
    endif
    # execute(cmd, "silent")
    execute(cmd)
    if Length() > 0 | break | endif
  endwhile
  Print()
enddef
