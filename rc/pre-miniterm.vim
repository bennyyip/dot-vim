vim9script
g:miniterm_dont_map = v:true
g:miniterm_dont_list = v:true

if $W64DEVKIT != ""
  g:miniterm_shell = [$HOME .. '/w64devkit/w64devkit.exe']
endif

# Helper to map in normal and terminal mode
def TerminalMap(map: string, com: string)
    execute $"inoremap <silent> {map} <Esc>{com}"
    execute $"nnoremap <silent> {map} {com}"
    execute $"tnoremap <silent> {map} <C-\\><C-n>{com}"
enddef


TerminalMap("<F12>", ":MinitermToggle<CR>")
TerminalMap("<F11>", ":MinitermToggle!<CR>")

command! -nargs=? TermCD {
  execute "Term cd " .. getcwd()
}
