vim9script

const SDL_PREFIX = $HOME .. "/sdl/x86_64-w64-mingw32"

$PKG_CONFIG_PATH = SDL_PREFIX .. "/lib/pkgconfig;" .. $PKG_CONFIG_PATH

call apathy#Prepend('path', SDL_PREFIX .. "/include/SDL2")
call apathy#Prepend('path', SDL_PREFIX .. "/include")

noremap <silent><buffer><F8> :Rooter<BAR>Make -j8<CR>
