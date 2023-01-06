#!/bin/bash
shopt -s dotglob
for D in $@;
do
    echo "linking file in [$D]";
    for P in `ls -a $D/*`;
    do
        F="$(basename -- $P)"
        echo "linking [$PWD/$P] to [$HOME/$F]" 
        ln -fs "$PWD/$P" "$HOME/$F"
    done
done