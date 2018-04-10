#!/usr/bin/env bash

export DOTFILES_DIR=`pwd`

# TODO: Have different path if this is on a CAEN computer
# TODO: Different path if repository is not in the developer directory

pushd $HOME                               # /dotfiles --> /$HOME
ln -s $DOTFILES_DIR/.vimrc $HOME
vim +PlugInstall +qall
                                          # TODO: Add the bin directory to the 
                                          # home directory
git clone \
  https://github.com/magicmonty/bash-git-prompt.git .bash-git-prompt --depth=1
popd                                      # /$HOME --> /dotfiles

# Create symlink to all files
declare -a to_move=(
                    ".aliases"
                    ".bash_functions"
                    ".bash_profile"
                    ".profile"
                    )

mkdir $HOME/old-dotfiles
for file in "${to_move[@]}"
do
  if find "$file" -maxdepth 0; then
    mv -v $HOME/$file $HOME/old-dotfiles/
  fi
  ln -s $HOME/developer/dotfiles/$file
done

read -p "Enter the name you would like for this machine (Prompt display): "\
  machine_name

echo "export MACHINE_NAME=$machine_name" > $HOME/.extra
