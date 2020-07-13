#!/bin/bash

vscode_dir=~/Library/Application\ Support/Code/User
dotfiles_dir=~/.dotfiles/vscode

function symlink() if [[ -L "$vscode_dir/$1" ]]; then
  echo "$vscode_dir/$1 is already a symlink. ignoring"
else
  if [[ -f "$vscode_dir/$1" || -d "$vscode_dir/$1" ]]; then
    echo "backing up existing config to $dotfiles_dir/$1_bak"
    mv "$vscode_dir/$1" "$dotfiles_dir/$1_bak"
  fi
  ln -s "$dotfiles_dir/$1" "$vscode_dir/$1"
fi

symlink "settings.json"
symlink "keybindings.json"
symlink "snippets"
