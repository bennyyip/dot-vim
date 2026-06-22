vim9script

var lsp_servers: list<dict<any>> = []

# C++ {{{1
if executable('ccls')
  lsp_servers->add({
    filetype: ["c", "cpp", "cuda", "objc", "objcpp"],
    name: 'ccls',
    path: 'ccls',
    initializationOptions: {
      "capabilities": {
        "foldingRangeProvider": false,
        "workspace": {
          "workspaceFolders": {
            "supported": false
          }
        }
      },
      "clang": {"extraArgs": ["--gcc-toolchain=/usr"]},
      "completion": {
        "detailedLabel": true,
        "placeholder": true
      },
      "client": {
        "snippetSupport": true
      },
      "index": {
        "onChange": false,
        "initialNoLinkage": true,
        "threads": 2,
        "initialBlacklist": ["/(test|unittests)/"]
      }
    }
  })
endif
# }}}
# ocaml {{{1
if executable('ocamllsp')
  lsp_servers->add({
    filetype: ["ocaml"],
    name: 'ocaml',
    path: 'ocamllsp',
  })
endif
# }}}
# zig {{{1
if executable('zls')
  lsp_servers->add({
    filetype: ["zig"],
    name: 'zig',
    path: 'zls',
  })
endif
# }}}
# lua {{{1
if executable('lua-language-server')
  lsp_servers->add({
    filetype: ["lua"],
    name: 'luals',
    path: 'lua-language-server',
  })
endif
# }}}
# python {{{1
const python_workspace_root = [
  "pyproject.toml",
]

if executable('basedpyright-langserver')
  lsp_servers->add({
    name: 'pyright',
    filetype: 'python',
    path: 'basedpyright-langserver',
    args: ['--stdio'],
    features: {
      # leave these to ruff
      diagnostics: false,
      # codeAction: false,
      documentFormatting: false,
      documentRangeFormatting: false,
      executeCommand: false,
    },

    rootSearch: python_workspace_root,
    runIfSearch: python_workspace_root,

    workspaceConfig: {
      basedpyright: {
        analysis: {
          autoSearchPaths: true,
          autoImportCompletions: false,
          disableOrganizeImports: true,
          disableTaggedHints: true,
        }
      }
    }
  })
endif

if executable('ruff')
  lsp_servers->add({
    filetype: 'python',
    name: 'ruff',
    path: 'ruff',
    # args: ['server', '-v', '--config', $HOME .. '/ruff.toml']
    args: ['server'],

    rootSearch: python_workspace_root,
    runIfSearch: python_workspace_root,
  })
endif
# }}}
# typescript {{{1
if executable('typescript-language-server')
  lsp_servers->add({
    filetype: ['javascript', 'typescript'],
    name: 'typescript-language-server',
    path: has('win32') ? $HOME .. '/AppData/Local/pnpm/bin/typescript-language-server.CMD' : '/usr/bin/typescript-language-server',
    rootSearch: ['node_modules/'],
    args: ['--stdio']
  })
endif
# }}}
# rust {{{1
if executable('rust-analyzer')
  lsp_servers->add({
    name: 'rustanalyzer',
    filetype: ['rust'],
    path: 'rust-analyzer',
    args: [],
    syncInit: true
  })
endif
# }}}
# odin {{{1
if executable('odin-ls')
  lsp_servers->add({
    name: 'ols',
    filetype: ['odin'],
    path: 'odin-ls',
    rootSearch: ['ols.json'],

    initializationOptions: {
      enable_auto_import: false,
      enable_fake_methods: true,
      enable_overload_resolution: true,
    },
  })
endif
# }}}
# zig {{{1
if executable('zls')
  lsp_servers->add({
    name: 'zls',
    filetype: ['zig'],
    path: 'zls',
  })
endif
# }}}

def DisableDiag()
  g:LspOptionsSet({
    showDiagInBalloon: false,
    showDiagInPopup: false,
    showDiagWithSign: false,
    showDiagWithVirtualText: false,
    showDiagOnStatusLine: false,
    autoPopulateDiags: false,
  })
  # HACK
  g:LspOptionsSet({
    autoHighlightDiags: false,
  })
  echo "Disable LSP Diagnotic."
enddef

def EnableDiag()
  g:LspOptionsSet({
    showDiagInBalloon: true,
    showDiagInPopup: true,
    showDiagWithSign: true,
    autoPopulateDiags: true,
    showDiagWithVirtualText: false,
    showDiagOnStatusLine: true,
    autoHighlightDiags: true,
  })
  LspDiagShow
enddef
def ToggoleDiag()
  if g:LspOptionsGet()['autoHighlightDiags']
    DisableDiag()
  else
    EnableDiag()
  endif
enddef

command! LspDisableDiag DisableDiag()
command! LspEnableDiag EnableDiag()

def LspSetup()
  nnoremap <silent><buffer> gd        <Cmd>execute v:count  .. 'LspGotoDefinition'<CR>
  nnoremap <silent><buffer> 'd        <Cmd>execute 'vertical '  .. v:count .. 'LspGotoDefinition'<CR>
  # nnoremap <silent><buffer> gi        <Cmd>LspGotoImpl<CR>
  nnoremap <silent><buffer> gt        <Cmd>LspGotoTypeDef<CR>
  nnoremap <silent><buffer> gr        <Cmd>LspShowReferences<CR>
  nnoremap <silent><buffer> <F2>      <Cmd>LspRename<CR>

  nnoremap <silent><buffer> <localleader>\ <cmd>LspDocumentSymbol<CR>
  nnoremap <silent><buffer> <LocalLeader>s <Cmd>LspShowSignature<CR>
  nnoremap <silent><buffer> <localleader>h <Cmd>LspHighlight<CR>
  nnoremap <silent><buffer> <localleader>H <Cmd>LspHighlightClear<CR>
  nnoremap <silent><buffer> <LocalLeader>a <Cmd>LspCodeAction<CR>
  nnoremap <silent><buffer> <LocalLeader>= <Cmd>LspFormat<CR>
  xnoremap <silent><buffer> <LocalLeader>e <Cmd>LspSelectionExpand<CR>
  xnoremap <silent><buffer> <LocalLeader>s <Cmd>LspSelectionShrink<CR>

  inoremap <silent><buffer> <C-G>s <C-R>=g:LspShowSignature()<CR>

  nnoremap <silent><buffer> yod <scriptcmd>ToggoleDiag()<CR>

  nnoremap <silent><buffer> <leader>m <cmd>LspHighlight<CR>
  nnoremap <silent><buffer> <leader>M <cmd>LspHighlightClear<CR>

  setlocal tagfunc=lsp#lsp#TagFunc
  setlocal keywordprg=:LspHover

  command! -buffer LspStop {
    setlocal tagfunc=
    setlocal keywordprg=:Man

    :silent! LspServer stop
    :silent! nunmap <buffer> gd
    :silent! nunmap <buffer> 'd
    :silent! # nunmap <buffer> gi
    :silent! nunmap <buffer> gt
    :silent! nunmap <buffer> gr
    :silent! nunmap <buffer> <F2>

    :silent! nunmap <buffer> <LocalLeader>s
    :silent! nunmap <buffer> <localleader>h
    :silent! nunmap <buffer> <localleader>H
    :silent! nunmap <buffer> <LocalLeader>a
    :silent! nunmap <buffer> <LocalLeader>=
    :silent! xunmap <buffer> <LocalLeader>e
    :silent! xunmap <buffer> <LocalLeader>s
    :silent! iunmap <buffer> <C-G>s
    :silent! nunmap <buffer> yod
  }
enddef

augroup vimrc
  autocmd User LspAttached call LspSetup()
augroup END

highlight link LspSigActiveParameter Type

# MUST set options before add server
var lsp_options = {
  autoComplete: false,
  omniComplete: true,
  completionMatcher: 'fuzzy', # case | fuzzy | icase
  usePopupInCodeAction: true,
  showSignature: false,
  semanticHighlight: false,
  condensedCompletionMenu: true,
  useQuickfixForLocations: true,
  ignoreCompleteItemsIsIncomplete: ['rustanalyzer'],

  popupBorder: true,
  popupBorderChars: ['─', '│', '─', '│', '┌', '┐', '┘', '└'],
  popupBorderHighlight: 'Identifier',
  popupHighlight: 'Normal',
  popupBorderSignatureHelp: false,
  popupHighlightSignatureHelp: 'Pmenu',
}
g:LspOptionsSet(lsp_options)
silent! DisableDiag()
g:LspAddServer(lsp_servers)

#  vim:fdm=marker
