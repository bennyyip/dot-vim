" Plugin: airblade/vim-rooter

let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_manual_only = 1
let g:rooter_cd_cmd="lcd"
let g:rooter_patterns = ['Cargo.toml', 'mix.exs', 'Makefile', '.git/', '.svn/']

nmap <silent> <leader>r :Rooter<CR>
