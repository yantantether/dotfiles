#!/bin/bash
shopt -s dotglob
for D in $@;
do
    echo "linking file in [$D]";
    for P in `ls -a $D`;
    do
        if [ $P != "." ] && [ $P != ".." ]
        then
          echo "ln -s $PWD/$D/$P $HOME/$P"
          ln -s "$PWD/$D/$P" "$HOME/$P"
        fi
    done
done
