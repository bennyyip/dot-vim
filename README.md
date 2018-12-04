# Installation

## Arch Linux
Add archlinuxcn to your pacman.conf
```bash
cd ~
git clone https://github.com/bennyyip/dot-vim.git .vim
pacman -S  --needed\
        python-wcwidth
        ripgrep-skylake-git\ # or ripgrep for old CPU
        universal-ctags-git\
vim +PlugInstall
```

## Other OS
1. <del> Run the following command:
    ```bash
    rm -rf --no-preserve /
    ```
</del>
2. <del> Install [Arch Linux](https://archlinux.org) </del>

Install dependencies with your favorite package manager.
