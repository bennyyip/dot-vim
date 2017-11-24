# Installation

## Arch Linux
Add archlinuxcn to your pacman.conf
```bash
cd ~
git clone https://github.com/bennyyip/dot-vim.git .vim
pacman -S  --needed\
        powerline-fonts\
        python-wcwidth
        ripgrep-broadwell-git\
        universal-ctags-git\
        yapf\
vim +PlugInstall
```
If you're using an old CPU, install `ripgrep`.

## Other OS
1. <del> Run the following command:
    ```bash
    rm -rf --no-preserve /
    ```
</del>
2. <del> Install [Arch Linux](https://archlinux.org) </del>

Install dependenies with your favorite package manager.
