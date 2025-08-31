vim9script

set history=3000
set updatetime=300
set updatecount=100

set undofile
set backup
# set backupskip=
set backupext=-vimbackup

set backupdir=$VIMSTATE/backup/
set directory=$VIMSTATE/swap/
set undodir=$VIMSTATE/undo/
set viminfo='100,/500,<50,s10,h,n$VIMSTATE/info/viminfo
set viewdir=$VIMSTATE/view

for d in ['backup', 'swap', 'undo', 'info', 'view']
  mkdir($VIMSTATE .. d, 'p')
endfor
