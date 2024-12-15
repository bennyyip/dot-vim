vim9script
g:swap_no_default_key_mappings = 1

omap ia <Plug>(swap-textobject-i)
xmap ia <Plug>(swap-textobject-i)
omap aa <Plug>(swap-textobject-a)
xmap aa <Plug>(swap-textobject-a)
xmap aa <Plug>(swap-textobject-a)

nmap g< <Plug>(swap-prev)
nmap g> <Plug>(swap-next)
nmap gS <Plug>(swap-interactive)
xmap gs <Plug>(swap-interactive)
