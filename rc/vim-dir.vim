vim9script
import autoload 'dir/action.vim'
import autoload 'dir/mark.vim'

g:dir_columns = "name"
g:dir_show_hidden = v:false
g:dir_invert_split = v:true

nmap -  :<C-u>Dir<CR>

def CustomizeMappings()
  # Customize key mappings here
  nmap <buffer> gg 4G
  nnoremap <buffer> gb :b<space>
  nnoremap <buffer> gB <scriptcmd>action.BookmarkJumpMenu()<cr>

  noremap <buffer> < <scriptcmd>action.WidenView()<cr>
  noremap <buffer> > <scriptcmd>action.ShrinkView()<cr>
  # noremap <buffer> < <scriptcmd>action.WidenView(v:count > 0)<cr>
  # noremap <buffer> > <scriptcmd>action.ShrinkView(v:count > 0)<cr>
  noremap <buffer> <silent> <BS> <cmd>nohlsearch<CR>
  if plugpac#HasPlugin("LeaderF")
    nmap <buffer> <leader>ff <leader>.
    nnoremap <buffer> <leader>.  <scriptcmd>execute($'Leaderf file {b:dir_cwd}')<cr>
  endif
  nnoremap <buffer> g:   <scriptcmd>DoFillCmdline("AsyncCmd", 'n')<cr>
  nnoremap <buffer> g;   <scriptcmd>DoFillCmdline("", 'n')<cr>
  xnoremap <buffer> g:   <scriptcmd>DoFillCmdline("AsyncCmd", 'v')<cr>
  xnoremap <buffer> g;   <scriptcmd>DoFillCmdline("", 'v')<cr>
  nnoremap <buffer> cd   <scriptcmd>execute($'lcd {b:dir_cwd}')<cr>
  nnoremap <buffer> g?   <cmd>help vim-dir-mappings<cr>
  nmap     <buffer> <F1> g?
enddef

def DoFillCmdline(prefix: string, mode: string)
  var files: list<any> = []
  if mode == 'v'
    files = action.VisualItemsInList(line('v'), line('.'))
  else
    files = mark.List()
    if files->len() == 0
      files = action.VisualItemsInList(line('v'), line('.'))
    endif
  endif

  var cmdline = $":\<C-U>{prefix} {files->mapnew("v:val.name")->join(" ")}\<HOME>"
  if prefix != ''
    cmdline ..= "\<S-Right> "
  endif
  feedkeys(cmdline)
enddef


augroup vimrc
  autocmd FileType dir CustomizeMappings()
augroup END
