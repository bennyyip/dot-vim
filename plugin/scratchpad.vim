vim9script

const slash = exists('+shellslash') && !&shellslash ? '\' : '/'
const scratchpad_dir = $HOME .. '/.local/state/vim/' .. ".scratchpads"
g:scratchpad_dir = scratchpad_dir

const path_pattern = scratchpad_dir .. slash

augroup scratchpad
  autocmd!
  execute 'autocmd BufNewFile,BufRead ' path_pattern 'scratchpad.* setlocal bufhidden=hide nobuflisted noswapfile'
  execute 'autocmd BufLeave' path_pattern .. 'scratchpad.*' 'update'
augroup END


def OpenScratchPad(ftype: string)
  var ext: string
  var ft = ftype
  if ft != ""
    ext = ft
  else
    ft = &filetype
    ext = expand('%:e')
    if ext == ''
      ext = ft
    endif
  endif

  if ft == ''
    ft = input('Enter filetype or leave empty to cancel. Scratchpad filetype: ', 'text', 'filetype')
    ext = ft
  endif

  if ft == ''
    echoerr 'No filetype given. Scratchpad cancelled.'
    return
  endif

  if ft == 'python'
    ext = 'py'
  elseif ft == 'rust'
    ext = 'rs'
  endif

  const path = $"{scratchpad_dir}{slash}scratchpad.{ext}"
  var scr_buf = bufnr(path)
  if scr_buf == -1
    if !isdirectory(scratchpad_dir)
      mkdir(scratchpad_dir, 'p')
    endif
    execute $"{SplitWindow()} new {fnameescape(path)}"
    # execute $"setf {ft}"
  else
    const scr_win = bufwinnr(scr_buf)
    if scr_win != -1
      if winnr() != scr_win
        execute $":{scr_win} wincmd w"
      endif
    else
      execute $"{SplitWindow()} split"
      execute $"buffer {scr_buf}"
    endif
  endif
enddef


def SplitWindow(): string
  var height = winheight(0) * 5
  var width = winwidth(0) * 2
  if height > width
    return 'aboveleft '
  else
    return 'topleft vertical'
  endif
enddef

command -nargs=? -complete=syntax Scratchpad OpenScratchPad(<q-args>)
