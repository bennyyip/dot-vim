" Key Mapping [[[1
let s:is_win = has('win32')
let s:is_gvim = has('gui_running')
" misc [[[2
nmap     t= mxHmygg=G`yzt`x
nmap     tj Jx

nnoremap <localleader>j :set ft=javascript<CR>
nnoremap <localleader>h :set ft=html<CR>
" toogle line number and relative line number
function! s:number_options() abort
  return &number && &relativenumber ? 'nonumber norelativenumber' : 'number relativenumber'
endfunction
nnoremap yoN :set <C-R>=<SID>number_options()<CR><CR>
nnoremap [oN :set number relativenumber<CR>
nnoremap ]oN :set nonumber norelativenumber<CR>

" gx
nmap gX <Plug>NetrwBrowseX
nno <silent> <Plug>NetrwBrowseX :call netrw#BrowseX(netrw#GX(),netrw#CheckIfRemote(netrw#GX()))<cr>
xmap gX <Plug>NetrwBrowseXVis
xno <silent> <Plug>NetrwBrowseXVis :<c-u>call netrw#BrowseXVis()<cr>

" fold [[[3
nmap z] zo]z
nmap z[ zo[z
" correct spell [[[3
cab Q q
cab Qa qa
cab W w
cab Wq wq
cab Wa wa
cab X x
" syntax [[[3
" nnoremap <leader>si  :echo ben#syninfo()<cr>
" nnoremap <leader>ss  :echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')<cr>
" diff [[[3
nnoremap <silent><leader>di :windo diffthis<CR>
nnoremap <silent><leader>du :windo diffupdate<CR>
nnoremap <silent><leader>do :windo diffoff<CR>
" linewise partial staging in visual-mode.
xnoremap <c-p> :diffput<cr>
xnoremap <c-o> :diffget<cr>
" toggle iwhite
nnoremap yo<space> :set <C-R>=(&diffopt =~# 'iwhite') ? 'diffopt-=iwhite' : 'diffopt+=iwhite'<CR><CR>
" quickfix and loclist [[[3
nnoremap <silent>  <q :call quickfixed#older()<CR>
nnoremap <silent>  >q :call quickfixed#newer()<CR>
" nohl [[[3
" Use <backspace> to:
"   - redraw
"   - clear 'hlsearch'
"   - update the current diff (if any)
" Use {count}<backspace> to:
"   - reload (:edit) the current buffer
nnoremap <silent><expr> <backspace> (v:count ? ':<C-U>:call ben#save_change_marks()\|edit\|call ben#restore_change_marks()<CR>' : '')
      \ . ':nohlsearch'.(has('diff')?'\|diffupdate':'')
      \ . '<CR><C-L>'
nnoremap z. :call ben#save_change_marks()<Bar>w<Bar>call ben#restore_change_marks()<cr>z.
nnoremap <leader>v :call ben#daily_note()<CR>
" window [[[2
" quick <C-w>
nnoremap ' <C-w>
if s:is_win || s:is_gvim
  let g:tmux_navigator_no_mappings=1
  nnoremap <silent><C-h> <C-w>h
  nnoremap <silent><C-j> <C-w>j
  nnoremap <silent><C-k> <C-w>k
  nnoremap <silent><C-l> <C-w>l
endif
" edit [[[2
inoremap (<CR> (<CR>)<Esc>O
inoremap {<CR> {<CR>}<Esc>O
inoremap {; {<CR>};<Esc>O
inoremap {, {<CR>},<Esc>O
inoremap [<CR> [<CR>]<Esc>O
inoremap [; [<CR>];<Esc>O
inoremap [, [<CR>],<Esc>O
inoremap <M-o> <C-O>o
inoremap <M-O> <C-O>O
" script helper
inoreabbrev <expr> #!! "#!/usr/bin/env" . (empty(&filetype) ? '' : ' '.&filetype)
" get output from python
imap <C-R>c <esc>:let @a=""<CR>:let @a = execute( "py3 print()")<left><left><left>
" time
inoremap <silent> <C-G><C-T> <C-R>=repeat(complete(col('.'),map(["%Y-%m-%d %H:%M:%S","%a, %d %b %Y %H:%M:%S %z","%Y %b %d","%d-%b-%y","%a %b %d %T %Z %Y"],'strftime(v:val)')+[localtime()]),0)<CR>
" yank and paste [[[2
cnoremap <C-v>         <C-R>+
inoremap <silent><C-v> <C-O>:set paste<CR><C-R>+<C-O>:set nopaste<CR>
inoremap <silent><C-z> <ESC>u
xnoremap <silent>Y     "+y
xnoremap <silent><C-c> "+y
nnoremap Y   y$
xnoremap x  "_d
xnoremap P  "0p
nmap     tp "+P
" select what I just pasted
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
" copy entire file contents (to gui-clipboard if available)
nnoremap yY :let b:winview=winsaveview()<bar>exe 'keepjumps keepmarks norm ggVG'.(has('clipboard')?'"+y':'y')<bar>call winrestview(b:winview)<cr>
" vimrc
nnoremap <leader>fed :e $VIMRC<CR>
nnoremap <leader>fee :source $VIMRC<CR>
" run current line
nnoremap <silent> yr :exec getline('.') \| echo 'executed!'<CR>
" visual [[[2
" keep selection when indent line in visual mode
xnoremap <expr> > v:count ? ">" : ">gv"
xnoremap <expr> < v:count ? "<" : "<gv"
" niceblock
xnoremap <expr> I (mode()=~#'[vV]'?'<C-v>^o^I':'I')
xnoremap <expr> A (mode()=~#'[vV]'?'<C-v>0o$A':'A')

" quick edit macro  | ["register]<leader>m
nnoremap <leader>em  :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>
nnoremap Q @q
xnoremap Q :normal @q<CR>
" repeat last command for each line of a visual selection
xnoremap . :normal .<CR>
" search and substitute [[[2
" quick substitute
vnoremap qs "zy:%s`<C-R>z``g<left><left>
nnoremap qs :%s`<C-R><C-W>``g<left><left>
vnoremap qS "zy:%S`<C-R>z``g<left><left>
nnoremap qS :%S`<C-R><C-W>``g<left><left>
nnoremap & n:&&<CR>
xnoremap & n:&&<CR>
" mark position before search
nnoremap / ms/
" file, buffer [[[2
nnoremap <leader>fs :w<CR>
nnoremap <leader>fy :let @+=expand("%")<CR>:echo "buffer filename copied"<CR>
nnoremap <leader>fp :let @+=expand("%:p")<CR>:echo "buffer path copied"<CR>
nnoremap cd :lcd %:p:h<bar>pwd<cr>
nnoremap cu :lcd ..<bar>pwd<cr>

nnoremap <silent><leader><tab> :<C-u>b!#<CR>
" tab [[[2
nmap     T :tabnew<cr>
nnoremap ]t :tabn<cr>
nnoremap [t :tabp<cr>
noremap  <silent><C-tab> :tabprev<CR>
inoremap <silent><C-tab> <ESC>:tabprev<CR>
function! s:switch_tab(i)
  if tabpagenr() == a:i
    return ":tabprev\<CR>"
  else
    return ":tabn ".a:i."\<CR>"
  endif
endfunction
function! s:map_switch_tab()
  for l:i in range(1, 9)
    execute printf("nnoremap <silent><expr> <leader>%d <SID>switch_tab(%d)", l:i, l:i)
    if s:is_gvim
      execute printf("nnoremap <silent><expr> <M-%d> <SID>switch_tab(%d)", l:i, l:i)
    else
      " Use customized key code for alt mappings to avoid breaking macros like
      " `<ESC>j`, see:
      " https://github.com/bennyyip/dotfiles/blob/master/config/.config/alacritty/alacritty.yml
      " https://zhuanlan.zhihu.com/p/20902166
      execute printf("nnoremap <silent><expr> <ESC>]{0}%d~ <SID>switch_tab(%d)", l:i, l:i)
    endif
  endfor
endfunction
call s:map_switch_tab()
" move [[[2
nnoremap <Down> gj
nnoremap <Up> gk
inoremap <Down> <C-R>=pumvisible() ? "\<lt>Down>" : "\<lt>C-O>gj"<CR>
inoremap <Up>   <C-R>=pumvisible() ? "\<lt>Up>" : "\<lt>C-O>gk"<CR>
inoremap <M-j> <Down>
inoremap <M-k> <Up>
inoremap <M-h> <left>
inoremap <M-l> <Right>
noremap H ^
noremap L $
