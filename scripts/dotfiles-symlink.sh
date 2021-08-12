#!/bin/bash

files=$(ls ${HOME}/Documents/github/dotfiles -a -A -I .git -I .gitignore -I README.md -I scripts)

for f in ${files}; do
   ln -sf ${HOME}/Documents/github/dotfiles/${f} ${HOME}
done
