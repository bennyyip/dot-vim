vim9script
g:loaded_lightline = 1

const is_tty = !match(&term, 'linux')

g:qline_config = {
  separator:    {left: "\ue0b8", right: "\ue0be", margin: ' '},
  subseparator: {left: "\ue0b9", right: "\ue0b9", margin: ' '},
  mode_map: {
    n: "N ",
    v: "V ",
    V: "V ",
    i: "I ",
    R: "R ",
    s: "S ",
    t: "T ",
    c: "N ",
  },
  active: {
    left: [
      ['mode', 'paste'],
      ['git_branch', 'filename'],
      ['readonly', 'modified'],
    ],
    right: [
      ['filetype'],
      ['percent'],
      ['cocstatus', 'asyncrun', 'fileformat', 'fileencoding', 'filetype']
    ]
  },
  inactive: {
    left: [['filename'], ['modified'] ],
    right: [['lineinfo'], ['percent']],
    separator: {left: '', right: '', margin: ' '},
    subseparator: {left: '|', right: '|', margin: ' '},
  },
  insert: {
    separator:    {left: "\ue0b8", right: "\ue0be", margin: ' '},
    subseparator: {left: "\ue0b9", right: "\ue0b9", margin: ' '},
  },
  replace: {
    separator:    {left: "\ue0b8", right: "\ue0be", margin: ' '},
    subseparator: {left: "\ue0b9", right: "\ue0b9", margin: ' '},
  },
  component: {
    git_branch: {
    content: () => {
        try
          if expand('%:t') !~? 'undotree\|diffpanel' && &filetype !~? 'vaffle'
            const mark = (is_tty ? '' : "\ue0a0 ")
            const branch = fugitive#Head()
            return branch !=# '' ? mark .. branch : ''
          endif
        catch
        endtry
        return ''
      }
    },
    readonly: {
      content: () => &filetype !~? 'help\|vaffle\|undotree\|qf' && &readonly ? (is_tty ? 'RO' : "\ue0a2") : ''
    },
    modified: {
      content: () => &filetype =~# 'help\|vaffle\|undotree\|qf' ? '' : &modified ? '+' : &modifiable ? '' : '-'
    },
    cocstatus: {
      content: () => coc#status(),
    },
    asyncrun: {
      content: () => get(g:, 'asyncrun_status', '')
    },
  },
}

g:qline_config.colorscheme = 'lightline:gruvbox8'


# export def g:Tabline(): string
#   var s = ''
#   for i in range(tabpagenr('$'))
#     const tab = i + 1
#     const winnr = tabpagewinnr(tab)
#     const buflist = tabpagebuflist(tab)
#     const bufnr = buflist[winnr - 1]
#     const bufname = bufname(bufnr)
#     const bufmodified = getbufvar(bufnr, "&mod")
#
#     s ..= '%' .. tab .. 'T'
#     s ..= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
#     s ..= ' ' .. tab .. ' '
#     s ..= (bufname != '' ?  fnamemodify(bufname, ':t') : '[No Name] ')
#
#     if bufmodified
#       s ..= '[+] '
#     endif
#
#     if tab > 1
#       s ..= "\ue0b8"
#     endif
#
#   endfor
#
#   s ..= '%#TabLineFill#'
#   if (exists("g:tablineclosebutton"))
#     s ..= '%=%999XX'
#   endif
#   return s
# enddef
# set tabline=%{%Tabline()%}
