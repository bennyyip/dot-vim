This configuration is only tested on Windows.
```bash
cd ~
git clone https://github.com/bennyyip/dot-vim.git .vim
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

Then compile [YCM](https://github.com/Valloric/YouCompleteMe) and install binary dependencies for some plugins (e.g. Ag, clang-format).

Thank bigeagle for his [bigeagle/neovim-config](https://github.com/bigeagle/neovim-config) and his blog [我的 Vim  配置](https://bigeagle.me/2015/05/vim-config/)
