#!/bin/bash
########################################################
# setup.sh
# @CM
# set up symbolic links for dotfiles
########################################################

dir=~/etc/dotfiles
olddir=~/etc/dotfiles_old
files="mybashrc vimrc vim/pluginlist"

if [[ ! -d ~/.vim ]]; then
    mkdir ~/.vim
    mkdir ~/.vim/bundle
    cd ~/.vim/bundle
    git clone https://github.com/gmarik/Vundle.vim
    cd $dir
fi

# backup old files
echo "> Back up old dotfiles ..."
mkdir -p $olddir
for f in $files; do
    mv ~/.$f $olddir/
done
echo "done"


# create symbolic links
echo -n "> Create symbolic links for ..."
for f in $files; do
    echo -n "$f "
    ln -s $dir/$f ~/.$f
done
echo -e "\ndone"
