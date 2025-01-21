vim9script

var lsp_servers: list<dict<any>> = []

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
      "clang": {"extraArgs": ["--gcc-toolchain=/usr", "-std=c++20"]},
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

if executable('ocamllsp')
  lsp_servers->add({
    filetype: ["ocaml"],
    name: 'ocaml',
    path: 'ocamllsp',
  })
endif

# if executable('pyright-langserver')
#   lsp_servers->add({
#     name: 'pyright',
#     filetype: 'python',
#     path: 'pyright-langserver',
#     args: ['--stdio'],
#     workspaceConfig: {
#       python: {
#         pythonPath: '/usr/bin/python'
#       },
#       pyright: {
#         disableDocumentation: false,
#       }
#     }
#   })
# endif

if executable('pylsp')
  lsp_servers->add({
    filetype: 'python',
    name: 'pylsp',
    path: 'pylsp',
    features: {
      # leave these to ruff
      diagnostics: false,
      codeAction: false,
      documentFormatting: false,
      documentRangeFormatting: false,
      executeCommand: false,
    }
  })
endif

if executable('ruff')
  lsp_servers->add({
    filetype: 'python',
    name: 'ruff',
    path: 'ruff',
    args: ['server']
  })
endif

if executable('tsserver')
  lsp_servers->add({
    filetype: ['javascript', 'typescript'],
    name: 'tsserver',
    path: 'typescript-language-server',
    args: ['--stdio']
  })
endif

if executable('rust-analyzer')
  lsp_servers->add({
    name: 'rustlang',
    filetype: ['rust'],
    path: 'rust-analyzer',
    args: [],
    syncInit: true
  })
endif

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
    showDiagWithVirtualText: true,
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

def BindKeys()
  nnoremap <silent><buffer> gd        <Cmd>call MarkPush()<cr>:execute v:count  .. 'LspGotoDefinition'<CR>
  nnoremap <silent><buffer> <C-W>gd   <Cmd>call MarkPush()<cr>:execute 'topleft '  .. v:count .. 'LspGotoDefinition'<CR>
  nnoremap <silent><buffer> gi        <Cmd>LspGotoImpl<CR>
  nnoremap <silent><buffer> gt        <Cmd>LspGotoTypeDef<CR>
  nnoremap <silent><buffer> gr        <Cmd>LspShowReferences<CR>
  nnoremap <silent><buffer> <F2>      <Cmd>LspRename<CR>

  nnoremap <silent><buffer> <LocalLeader>s <Cmd>LspShowSignature<CR>
  nnoremap <silent><buffer> <localleader>h <Cmd>LspHighlight<CR>
  nnoremap <silent><buffer> <localleader>H <Cmd>LspHighlightClear<CR>
  nnoremap <silent><buffer> <LocalLeader>a <Cmd>LspCodeAction<CR>
  xnoremap <silent><buffer> <LocalLeader>e <Cmd>LspSelectionExpand<CR>
  xnoremap <silent><buffer> <LocalLeader>s <Cmd>LspSelectionShrink<CR>

  nnoremap <silent><buffer> yos <scriptcmd>ToggoleDiag()<CR>

  setlocal keywordprg=:LspHover
enddef

inoremap <silent><expr> <TAB> pumvisible() ? "\<C-N>" : "\<Tab>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-P>" : "\<C-H>"

# swap <c-n> and <c-x><c-n>
inoremap <silent><expr> <C-N> pumvisible() ?  "\<C-N>" : "\<C-X>\<C-N>"
inoremap <C-X><C-N> <C-N>
inoremap <silent><expr> <C-O> pumvisible() ? "\<C-N>" : "\<C-X>\<C-O>"

augroup vimrc
  autocmd User LspAttached call BindKeys()
augroup END

highlight link LspSigActiveParameter Type

# MUST set options before add server
var lsp_options = {
  autoComplete: false,
  omniComplete: true,
  usePopupInCodeAction: true,
  showSignature: true,
  semanticHighlight: false,
  condensedCompletionMenu: true,
}
g:LspOptionsSet(lsp_options)
silent! DisableDiag()
g:LspAddServer(lsp_servers)
