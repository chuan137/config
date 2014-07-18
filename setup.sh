#!/bin/bash
########################################################
# setup.sh
# @CM
# set up symbolic links for dotfiles
########################################################

dir=~/cache/dotfiles
olddir=~/cache/dotfiles_old
files="mybashrc vimrc vim/pluginlist"

# backup old files
echo -n "Backing up old dotfiles ..."
mkdir -p $olddir
for f in $files; do
    mv ~/.$f $olddir/$f
done
echo "done"


# create symbolic links
echo -n "Creating symbolic links for "
for f in $files; do
    echo -n "$f "
    ln -s $dir/$f ~/.$f
done
echo "...done"
