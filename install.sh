#!/usr/bin/env bash
for file in $(ls $HOME/.dotfiles/); do
    if [ ! -e "$HOME/.$file" ]; then
        ln -sf $HOME/.dotfiles/$file $HOME/.$file
    fi
done
