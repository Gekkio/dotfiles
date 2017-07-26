#!/bin/sh

set -e

if [ ! `which realpath` ]; then
  echo realpath must be installed!
  exit 1
fi

if [ ! `which readlink` ]; then
  echo readlink must be installed!
  exit 1
fi

SCRIPT_PATH=$(dirname $(realpath -s $0))

link() {
  TO=`realpath -s "$1"`
  FROM=`realpath -s "$2"`

  if [ ! -h "$TO" ] || [ `readlink "$TO"` != "$FROM" ]; then
    if [ -h "$STO" ] || [ -e "$TO" ]; then
      echo Cannot link "$TO"
    else
      echo Linking "$TO"
      ln -s "$FROM" "$TO"
    fi
  fi
}

# npm

mkdir -p "$HOME/.npm-packages"
if [ ! -e "$HOME/.npmrc" ]; then
  echo "prefix = $HOME/.npm-packages" > "$HOME/.npmrc"
fi

# tmux

link "$HOME/.tmux.conf" "$SCRIPT_PATH/tmux.conf"

# vim

mkdir -p "$HOME/.vim/bundle"
link "$HOME/.vim/vimrc" "$SCRIPT_PATH/vim/vimrc"
link "$HOME/.gvimrc" "$SCRIPT_PATH/vim/gvimrc"

# neovim

mkdir -p "$HOME/.config/nvim"
mkdir -p "$HOME/.local/share/nvim/bundle"
link "$HOME/.config/nvim/init.vim" "$SCRIPT_PATH/vim/vimrc"

# vim vundle
if [ ! -e "$HOME/.vim/bundle/Vundle.vim" ]; then
  if [ ! `which git` ]; then
    echo git must be installed!
    exit 1
  fi
  git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
fi

# neovim vundle
if [ ! -e "$HOME/.local/share/nvim/bundle/Vundle.vim" ]; then
  if [ ! `which git` ]; then
    echo git must be installed!
    exit 1
  fi
  git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.local/share/nvim/bundle/Vundle.vim
fi

# xmonad

mkdir -p "$HOME/.xmonad"

link "$HOME/.xmonad/xmonad.hs" "$SCRIPT_PATH/xmonad/xmonad.hs"

# zsh

link "$HOME/.zshenv" "$SCRIPT_PATH/zshenv"
link "$HOME/.zshrc" "$SCRIPT_PATH/zshrc"
