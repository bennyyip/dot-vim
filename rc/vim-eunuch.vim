vim9script

def RenameInteractive(name: string=null_string)
  const new_name = name == null_string ? input('New file name: ', expand('%:t')) : name
  execute 'Rename ' .. new_name
enddef

command -nargs=? -complete=dir RenameI call RenameInteractive(<q-args>)
