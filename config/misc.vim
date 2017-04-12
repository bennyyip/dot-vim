""Yggdroot/indentLine
let g:indentLine_noConcealCursor=""

"maralla/completor.vim
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"
let g:completor_gocode_binary = '/home/ben/go/bin/gocode'
let g:completor_clang_binary = '/usr/bin/clang'
let g:completor_python_binary = '/usr/bin/python'
let g:completor_racer_binary = '/usr/bin/racer'


map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

"haya14busa/incsearch.vim
set ignorecase
set smartcase

" :h g:incsearch#auto_nohlsearch
set hlsearch
"nmap <silent><esc> :<c-u> nohl<CR>
"let g:incsearch#auto_nohlsearch = 1
"map n  <Plug>(incsearch-nohl-n)
"map N  <Plug>(incsearch-nohl-N)
"map *  <Plug>(incsearch-nohl-*)
"map #  <Plug>(incsearch-nohl-#)
"map g* <Plug>(incsearch-nohl-g*)
"map g# <Plug>(incsearch-nohl-g#)

let g:tagbar_width = 30

nmap tb :TagbarToggle<cr>

"" majutsushi/tagbar
let g:tagbar_type_tex = {
      \ 'ctagstype' : 'latex',
      \ 'kinds'  : [
      \ 's:sections',
      \ 'g:graphics:1',
      \ 'l:labels:1',
      \ 'r:refs:1',
      \ 'p:pagerefs:1'
      \ ],
      \ 'sort'  : 0
      \ }

let g:tagbar_type_nc = {
      \ 'ctagstype' : 'nesc',
      \ 'kinds'  : [
      \ 'd:definition',
      \ 'f:function',
      \ 'c:command',
      \ 'a:task',
      \ 'e:event'
      \ ],
      \ }


""junegunn/goyo.vim
nnoremap <silent> <leader>z :Goyo<cr>
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

""junegunn/limelight.vim
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240
" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'

""kien/rainbow_parentheses.vim
let g:rbpt_colorpairs = [
      \ [158, '#00ceb3'],
      \ [081, '#00a3ff'],
      \ [214, '#ff8d00'],
      \ [123, '#3fffc9'],
      \ [045, '#29b9ec'],
      \ [190, '#bfec29'],
      \ [208, '#ffad00'],
      \ [117, '#48bde0'],
      \ ]

let g:rbpt_max = 8
let g:rbpt_loadcmd_toggle = 0

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax c,cpp,go,h,java,python,javascript,scala,coffee,rust RainbowParenthesesLoadSquare
au Syntax c,cpp,go,h,java,python,javascript,scala,coffee,scss,rust  RainbowParenthesesLoadBraces


" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>  <Plug>(neosnippet_expand_or_jump)
smap <C-k>  <Plug>(neosnippet_expand_or_jump)
xmap <C-k>  <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>  <Plug>(neosnippet_expand_or_jump)
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \  "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
"if has('conceal')
"  set conceallevel=2 concealcursor=niv
"endif

let g:neosnippet#disable_runtime_snippets = {
      \  '_' : 1,
      \ }
let g:neosnippet#snippets_directory = '~/.vim/snippets'

" Unwanted spaces

function! TrimSpaces()
  if !&binary && &filetype != 'diff' && &filetype != 'markdown'
    %s/\s\+$//e
  endif
endfunction

command! TrimSpaces call TrimSpaces()

"au * ShowSpaces
au BufWritePre * TrimSpaces
au FileAppendPre * TrimSpaces
au FileWritePre * TrimSpaces
au FilterWritePre * TrimSpaces
