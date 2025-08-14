vim9script

# insert mode completion
set completepopup=highlight:Pmenu,border:off
# set completeopt=menu,longest,menuone,popup,noselect
set completeopt=menu,popup,preview #,fuzzy
set completefuzzycollect=keyword
set complete=.^7,w^5,b^5,u^3
set complete+=Fcompletor#Abbrev^3
set complete+=Fcompletor#Register^5
set complete^=Fcompletor#Lsp^10

# set autocomplete

# command line completion
set wildmenu wildmode=full wildoptions=pum,fuzzy pumheight=20
set wildignore=*.o,*.obj,*.bak,*.exe,*.swp,tags,*.cmx,*.cmi,*~,*.py[co],__pycache__

# swap <c-n> and <c-x><c-n> and <c-o>
inoremap <expr> <C-N> pumvisible() ?  "\<C-N>" : "\<C-X>\<C-N>"
inoremap <C-X><C-N> <C-N>
inoremap <C-O> <C-N>
# inoremap <silent><expr> <C-O> pumvisible() ? "\<C-N>" : "\<C-X>\<C-O>"

inoremap <silent><expr> <TAB> pumvisible() ? "\<C-N>" : "\<Tab>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-P>" : "\<C-H>"
