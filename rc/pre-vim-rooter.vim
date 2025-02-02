vim9script
# Plugin: airblade/vim-rooter

g:rooter_change_directory_for_non_project_files = 'current'
g:rooter_manual_only = 1
g:rooter_resolve_links = 1
g:rooter_cd_cmd = "lcd"
g:rooter_patterns = ['dune-project', 'Cargo.toml', 'mix.exs', 'Makefile', '.git/', '.svn/', '.project.vim',]

def SourceProjectVimrc()
  const root = g:FindRootDirectory()
  if root == ''
    return
  endif
  const projectvimrc = root .. '/.project.vim'
  if filereadable(projectvimrc)
    execute $'source {projectvimrc}'
  endif
enddef


nmap <silent> <leader>r :silent! Rooter<bar>pwd<CR>

augroup vimrc
  autocmd BufReadPost,BufEnter * SourceProjectVimrc()
augroup END
