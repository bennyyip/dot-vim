vim9script

import autoload 'yat.vim'

g:yat_padding_left = 3

g:yat_header = [
  "             ________ ++     ________             ",
  '            /VVVVVVVV\++++  /VVVVVVVV\            ',
  '            \VVVVVVVV/++++++\VVVVVVVV/            ',
  "             |VVVVVV|++++++++/VVVVV/'             ",
  "             |VVVVVV|++++++/VVVVV/'               ",
  "            +|VVVVVV|++++/VVVVV/'+                ",
  "          +++|VVVVVV|++/VVVVV/'+++++              ",
  "        +++++|VVVVVV|/VVV___++++++++++            ",
  "          +++|VVVVVVVVVV/##/ +_+_+_+_             ",
  '            +|VVVVVVVVV___ +/#_#,#_#,\            ',
  "             |VVVVVVV//##/+/#/+/#/'/#/            ",
  "             |VVVVV/'+/#/+/#/+/#/ /#/             ",
  "             |VVV/'++/#/+/#/ /#/ /#/              ",
  "             'V/'  /##//##//##//###/              ",
  "                      ++                          ",
  "                                                  ",
  "                                                  ",
  "           vi vi vi, the editor of the beast.     ",
]


command! Yat yat.Open()

augroup yat
  autocmd VimEnter *  {
    if argc() == 0
      yat.Open()
    endif
  }
augroup END
