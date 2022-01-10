#!/bin/bash

sudo apt-get install -y neovim python2 python3
pip install neovim --user
pip3 install neovim --user

git clone https://github.com/masters-of-cats/a-new-hope ~/.config/nvim

nvim --headless +PlugInstall +PlugUpdate +GoUpdateBinaries +qall
nvim --headless +UpdateRemotePlugins +qall
