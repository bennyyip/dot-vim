vim9script
# ==============================================================================
# Fuzzy-select files, buffers, args, tags, help tags, oldfiles, marks
# File:         plugin/fzy.vim
# Author:       bfrg <https://github.com/bfrg>
# Website:      https://github.com/bfrg/vim-fzy
# Last Change:  2026-10-15
# License:      Same as Vim itself (see :h license)
# ==============================================================================

import autoload '../autoload/fzy.vim'


command -nargs=? -complete=dir FzyFind      fzy.Find(empty(<q-args>) ? getcwd() : <q-args>)
command -bar -bang FzyBuffers               fzy.Buffers(<bang>0)
command -nargs=* -bar -bang FzyMarks        fzy.Marks(<bang>0, <q-args>)
command! -bar -bang -nargs=* FzyBMarks      fzy.Marks(<bang>0, "abcdefghijklmnopqrstuvwxyz")
# command -bar FzyOldfiles                   fzy.Oldfiles()
command -bar FzyArgs                        fzy.Arg(false)
command -bar FzyLargs                       fzy.Arg(true)

command -bar FzyHelp  fzy.Help()
command -bar FzyTag fzy.Tags()
command -nargs=+ -complete=file FzyGrep      fzy.Grep('buffer', <q-args>)

command -nargs=* BLines fzy.Blines(<q-args>)

command FzyToc fzy.MarkdownOutline()

nnoremap <silent> <localleader>\ <cmd>FzyTag<CR>
