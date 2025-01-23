vim9script
def Quote(): list<string>
  const quotes = [
    ["vi vi vi, the editor of the beast."]
  ]
  const quote = quotes[rand() % len(quotes)]
  var lines = []
  for l in quote
    const offset = 50 - strwidth(l)
    lines += [repeat(' ', offset) .. l ]
  endfor
  return lines
enddef

const ascii_art = [
  "             ________ ++     ________             ",
  "            /VVVVVVVV\++++  /VVVVVVVV\\           ",
  "            \VVVVVVVV/++++++\VVVVVVVV/            ",
  "             |VVVVVV|++++++++/VVVVV/'             ",
  "             |VVVVVV|++++++/VVVVV/'               ",
  "            +|VVVVVV|++++/VVVVV/'+                ",
  "          +++|VVVVVV|++/VVVVV/'+++++              ",
  "        +++++|VVVVVV|/VVV___++++++++++            ",
  "          +++|VVVVVVVVVV/##/ +_+_+_+_             ",
  "            +|VVVVVVVVV___ +/#_#,#_#,\\           ",
  "             |VVVVVVV//##/+/#/+/#/'/#/            ",
  "             |VVVVV/'+/#/+/#/+/#/ /#/             ",
  "             |VVV/'++/#/+/#/ /#/ /#/              ",
  "             'V/'  /##//##//##//###/              ",
  "                      ++                          ",
  "                                                  ",
  "                                                  ",
]
g:startify_custom_header = ascii_art->extendnew(Quote())
g:startify_skiplist = [
  'COMMIT_EDITMSG',
]
g:starify_bookmarks = [
  { 'c': $VIMRC },
]
g:startify_transformations = [
  ['.*vimrc$', 'vimrc'],
]
g:startify_lists = [
  { 'type': 'sessions',  'header': ['   Sessions']       },
  { 'type': 'files',     'header': ['   MRU']            },
  { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
  { 'type': 'commands',  'header': ['   Commands']       },
]

g:startify_change_to_dir = 0
g:startify_change_to_vcs_root = 1
g:startify_enable_special = 0
g:startify_files_number = 7
g:startify_session_dir = $VIMSTATE .. '/session'
g:startify_session_autoload = 0
g:startify_session_persistence = 0
g:startify_update_oldfiles = 1
g:startify_use_env = 0


augroup vimrc
  autocmd FileType startify ++once hi StartifyHeader ctermfg=214 ctermbg=NONE guifg=#fabd2f guibg=NONE guisp=NONE cterm=NONE gui=NONE
augroup end
