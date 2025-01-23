vim9script
g:tlist_ocaml_settings = 'ocaml;c:classes;m:object method;M:module or functor;p:signature;t:type;f:function;C:constructor'
g:Tlist_Show_One_File = 1
g:Tlist_Process_File_Always = 1
g:Tlist_Enable_Fold_Column = false
# nnoremap <C-G><C-F> <cmd>TlistShowTag<CR>
nnoremap <C-G><C-F> <cmd>TlistShowPrototype<CR>
