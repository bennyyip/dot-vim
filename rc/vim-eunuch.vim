vim9script

def RenameInteractive()
  const new_name = input('New file name: ', expand('%:t'))
  execute 'Rename ' .. new_name
enddef

command -nargs=0 RenameI call RenameInteractive()
