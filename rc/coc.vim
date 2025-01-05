vim9script

# USAGE:
# <C-O> open complete menu
# <TAB> <S-TAB> select complete
# <C-T> goto next snippet placeholder

coc#add_extension()

autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

nnoremap <c-g><c-f> <cmd>echo get(b:, 'coc_current_function', ' ')<CR>

# By default <C-O> goto normal and play one command,
# which I never use
inoremap <silent><expr> <C-O> coc#refresh()

g:coc_snippet_next = '<C-T>'
imap <C-T> <Plug>(coc-snippets-expand-jump)

# Use tab for trigger completion with characters ahead and navigate
# NOTE: There's always complete item selected by default, you may want to enable
# no select by `"suggest.noselect": true` in your configuration file
# NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
# other plugin before putting this into your config
# inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#next(1) : g:CheckBackspace() ? "\<Tab>" : coc#refresh()
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#next(1) : pumvisible() ? "\<C-N>" : "\<Tab>"
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : pumvisible() ? "\<C-P>" : "\<C-H>"

# Make <CR> to accept selected completion item or notify coc.nvim to format
# <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

export def g:CheckBackspace(): bool
  const col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
enddef

# Use `[g` and `]g` to navigate diagnostics
# nmap <silent> [g <Plug>(coc-diagnostic-prev)
# nmap <silent> ]g <Plug>(coc-diagnostic-next)

# Remap keys for gotos
nmap <silent> gd <cmd>call MarkPush()<cr>:call CocAction("jumpDefinition")<cr>
nmap <silent> gy <cmd>call MarkPush()<cr>:call CocAction("jumpTypeDefinition")<cr>
# nmap <silent> gD <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

# Use K to show documentation in preview window
nnoremap <silent> K :call <SID>ShowDocumentation()<CR>

def ShowDocumentation()
  if (index(['vim', 'help'], &filetype) >= 0)
    execute 'h ' .. expand('<cword>')
  else
    call g:CocAction('doHover')
  endif
enddef

# Highlight symbol under cursor on CursorHold
augroup vimrc
  autocmd CursorHold * silent call CocActionAsync('highlight')
  # HACK: coc delay load
  autocmd BufRead * ++once CocStart
  autocmd FileType css setl iskeyword+=-
augroup end

# Remap for rename current word
nmap <f2> <Plug>(coc-rename)

# Map function and class text objects
# NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
# xmap ic <Plug>(coc-classobj-i)
# omap ic <Plug>(coc-classobj-i)
# xmap ac <Plug>(coc-classobj-a)
# omap ac <Plug>(coc-classobj-a)

# Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

# Use CTRL-S for selections ranges
# Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

vmap <localleader>a <Plug>(coc-codeaction-selected)
nmap <localleader>a <Plug>(coc-codeaction-selected)

nmap <leader>lf <Plug>(coc-fix-current)
nmap <leader>li <cmd>CocList outline<cr>

nnoremap <silent> <leader>cc :CocList commands<CR>

command! -nargs=0 Prettier :call CocActionAsync('runCommand', 'prettier.formatFile')
command! -nargs=0 Format :call CocActionAsync('format')
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

# nmap xn <cmd>CocNext<cr>
# nmap xp <cmd>CocPrev<cr>
