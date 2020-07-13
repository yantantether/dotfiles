#!/bin/bash

# Visual Studio Code :: Package list
pkglist=(
christian-kohler.path-intellisense
davidanson.vscode-markdownlint
EditorConfig.EditorConfig
foxundermoon.shell-format
mikestead.dotenv
ms-python.python
ms-python.vscode-pylance
ms-azuretools.vscode-docker
njpwerner.autodocstring
oderwat.indent-rainbow
shd101wyy.markdown-preview-enhanced
shuworks.vscode-table-formatter
stevejpurves.cucumber
yzane.markdown-pdf
)

for i in ${pkglist[@]}; do
  code --install-extension $i
done
