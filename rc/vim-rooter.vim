vim9script
# Plugin: airblade/vim-rooter

g:rooter_change_directory_for_non_project_files = 'current'
g:rooter_manual_only = 1
g:rooter_cd_cmd = "lcd"
g:rooter_patterns = ['Cargo.toml', 'mix.exs', 'Makefile', '.git/', '.svn/']

nmap <silent> <leader>r :Rooter<CR>
