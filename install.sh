#!/usr/bin/env bash
for file in $(ls $HOME/.dotfiles/); do
    if [ "$(readlink $HOME/.$file)" == "$HOME/.dotfiles/$file" ]; then
        continue
    fi
    ln -svf $HOME/.dotfiles/$file $HOME/.$file
done
