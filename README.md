> For linux you can just run
> ```bash
> curl -s https://raw.githubusercontent.com/masters-of-cats/a-new-hope/main/install.sh | bash -s
> ```
> if you like.

### Install required packages

#### Mac

```sh
brew install python3 python@2 neovim
pip install neovim
pip3 install neovim
```

#### Linux

```sh
sudo apt-get install neovim python2 python3
pip install neovim --user
pip3 install neovim --user
```

### Clone the repo

```sh
git clone https://github.com/masters-of-cats/a-new-hope ~/.config/nvim
```

### Install the plugins and binaries

```sh
nvim --headless +PlugInstall +PlugUpdate +GoUpdateBinaries +qall
nvim --headless +UpdateRemotePlugins +qall
```

### Start NeoVim

```sh
nvim <filename>
# or
nvim .
# or
nvim
```

Once you have opened NeoVim, if you see errors it is possible the headless install did not work.
Without closing NeoVim, type `:PlugInstall` and enter, followed by `:UpdateRemotePlugins` and enter.
If you get further errors, try completely uninstalling and then reinstalling Python, Python3, Pip, and Pip3.
