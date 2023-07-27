vim9script
# Plugin: neoclide/coc.nvim

g:coc_data_home = $v .. '/coc/'

g:coc_global_extensions = [
  'coc-json',
  'coc-pyright',
  'coc-snippets',
  'coc-spell-checker',
  'coc-tsserver',
  'coc-vimlsp',
  'coc-yaml',
  'coc-css',
  '@yaegassy/coc-marksman'
]
if matchstr(&rtp, 'coc.nvim') != ''
  call coc#add_extension()
endif

# g:coc_snippet_next = '<C-k>'

# Use tab for trigger completion with characters ahead and navigate
# NOTE: There's always complete item selected by default, you may want to enable
# no select by `"suggest.noselect": true` in your configuration file
# NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
# other plugin before putting this into your config
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#next(1) : g:CheckBackspace() ? "\<Tab>" : coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

# Make <CR> to accept selected completion item or notify coc.nvim to format
# <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

export def g:CheckBackspace(): bool
  const col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
enddef

inoremap <silent><expr> <c-space> coc#refresh()


# Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

# Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
# nmap <silent> gi <Plug>(coc-implementation)
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
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

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

vmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

nnoremap <silent> <leader>cc :CocList commands<CR>


command! -nargs=0 Prettier :call CocActionAsync('runCommand', 'prettier.formatFile')
command! -nargs=0 Format :call CocActionAsync('format')
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
