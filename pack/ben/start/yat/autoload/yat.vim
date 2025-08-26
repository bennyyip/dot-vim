vim9script

const padding_left = get(g:, 'yat_padding_left', 3)
const left_pad = repeat(' ', padding_left)

def SectionHeader(header: string)
  append("$", "")
  append("$", $"{left_pad}{header}")
  append("$", "")
  const l = line('$')
  b:yat_section_header_lines->extend([l - 2, l - 1, l])
enddef


def ShowSessionsAndMru()
  var lineidx = 0
  const session_dir = $VIMSTATE .. '/session'

  SectionHeader("Sessions")

  const sessions = readdir(session_dir)
  for session in sessions
    const line =  $"{left_pad}[{lineidx}]  {session}"
    execute $"nnoremap <buffer><silent><nowait> {lineidx} <cmd>%bd<BAR>source {session_dir}/{session}<CR>"
    append("$", line)
    lineidx += 1
  endfor

  SectionHeader("MRU")

  const mru = $HOME .. '/.vim_mru_files'
  const mru_files = readfile(mru, "", 11 - sessions->len())->slice(1)
  for file in mru_files
    const line =  $"{left_pad}[{lineidx}]  {file->fnamemodify(":~")}"
    execute $"nnoremap <buffer><silent><nowait> {lineidx} <cmd>edit {file->fnameescape()}<CR>"
    append("$", line)
    lineidx += 1
  endfor
enddef


export def Open()
  enew

  b:yat_section_header_lines = []

  setlocal modifiable modified noreadonly
  sil! keepj :%d _

  var l = 1
  while l <= g:yat_header->len()
    setline(l, g:yat_header[l - 1])
    l += 1
  endwhile

  ShowSessionsAndMru()

  b:yat_firstline = g:yat_header->len() + 4
  b:yat_lastline = line('$')

  cursor(b:yat_firstline, padding_left + 2)

  nnoremap <buffer><silent><nowait> <CR> <scriptcmd>execute $"normal {getline('.')[col('.') - 1]}"<CR>
  nnoremap <buffer><silent><nowait> q <cmd>q<CR>

  setlocal nomodifiable nomodified readonly
  normal! zb
  set ft=yat
enddef
