#!/usr/bin/env bash
for file in $(ls $HOME/.dotfiles/); do
    if [ -L "$HOME/.$file" ]; then
        continue
    fi
    ln -svf $HOME/.dotfiles/$file $HOME/.$file
done
