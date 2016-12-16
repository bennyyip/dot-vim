# Installation
This configuration is only tested on Windows.
```bash
cd ~
git clone https://github.com/bennyyip/dot-vim.git .vim
cd ~/.vim
mkdir ~/.swapfiles
```

Replace `~/.vimrc` with following lines if you are using windows:
```
if has('win32') || has('win64')
    set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after
    source ~/.vim/init.vim
endif
```

Open vim and run:
```
:PlugInstall
```

# Additional Works
All executables should be placed in environment varible `PATH` excepts YCM
- compile [YCM](https://github.com/Valloric/YouCompleteMe)
- install [Ag](https://github.com/ggreer/the_silver_searcher)
- install [ctags](https://github.com/universal-ctags/ctags)
- install [clang-format](http://llvm.org/) for C/C++ formatting
- install [Python3](https://www.continuum.io/downloads) (recommend anaconda if you use Windows)
- install font [Inziu Iosevka](https://be5invis.github.io/Iosevka/inziu)
- and other binary dependencies

# Thank
Thank bigeagle for his [bigeagle/neovim-config](https://github.com/bigeagle/neovim-config) and his blog [我的 Vim  配置](https://bigeagle.me/2015/05/vim-config/)
