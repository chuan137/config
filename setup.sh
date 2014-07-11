#!/bin/bash
########################################################
# setup.sh
# @CM
# set up symbolic links for dotfiles
########################################################

dir=~/archive/dotfiles
olddir=~/archive/dotfiles_old
files="mybashrc vimrc vim"

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
