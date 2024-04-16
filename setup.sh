#!/bin/bash

mkdir -p ~/.config/{nvim,wezterm,tmux,alacritty}

# neovim
ln -s ~/code/dotfiles/.config/nvim ~/.config/nvim

# wezterm
ln -s ~/code/dotfiles/.config/wezterm ~/.config/wezterm

# tmux
ln -s ~/code/dotfiles/.config/tmux ~/.config/tmux

# alacritty
ln -s ~/code/dotfiles/.config/alacritty ~/.config/alacritty

# ghostty
ln -s ~/code/dotfiles/.config/ghostty ~/.config/ghostty
