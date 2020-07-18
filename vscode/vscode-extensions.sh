#!/bin/bash

# store in this directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# install extension list
pkglist=(`cat $DIR/vscode-extensions.txt`)
for i in ${pkglist[@]}; do
  code --install-extension $i
done

# update extension list
code --list-extensions > $DIR/vscode-extensions.txt