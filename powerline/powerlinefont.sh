#!/bin/bash

if [ ! -f ~/.fonts/PowerlineSymbols ]; then
    mkdir ~/.fonts
    wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
    mv PowerlineSymbols.otf ~/.fonts
fi

if [ ! -f '~/.config/fontconfig/conf.d/10-powerline-symbols.conf' ]; then
    mkdir -p ~/.config/fontconfig/conf.d 
    wget https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
    mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d
fi

cp powerline-fonts ~/.fonts -r
fc-cache -vf ~/.fonts
