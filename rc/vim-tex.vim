vim9script
# Plugin: lervag/vimtex

g:tex_flavor='latex'
g:vimtex_quickfix_mode=0
set conceallevel=1
g:tex_conceal='abdmg'
# let g:tex_conceal=0
g:latex_view_general_viewer = 'zathura'
g:vimtex_view_method = "zathura"
# let g:vimtex_view_general_viewer = 'okular'
# let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
# let g:vimtex_view_general_options_latexmk = '--unique'


g:vimtex_compiler_latexmk = {
    'backend' : 'jobs',
    'background' : 1,
    'build_dir' : 'output',
    'callback' : 1,
    'continuous' : 1,
    'executable' : 'latexmk',
    'options' : [
      '-verbose',
      '-file-line-error',
      '-synctex=1',
      '-interaction=nonstopmode',
    ],
}


autocmd BufReadPre *.tex let b:vimtex_main = 'main.tex'
