vim9script

import autoload '../autoload/rooter.vim'

nmap <silent> <leader>r <scriptcmd>rooter.Rooter()<CR>
command! -bar -nargs=0 Rooter rooter.Rooter()
