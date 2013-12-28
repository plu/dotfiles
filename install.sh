#!/usr/bin/env bash
for file in $(ls $HOME/.dotfiles/); do
    ln -sf $HOME/.dotfiles/$file $HOME/.$file
done
