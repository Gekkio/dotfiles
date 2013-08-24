#!/bin/sh

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

# tmux

link "$HOME/.tmux.conf" "$SCRIPT_PATH/tmux.conf"

# vim

mkdir -p "$HOME/.local/share/vim/backup"
mkdir -p "$HOME/.local/share/vim/swap"
mkdir -p "$HOME/.local/share/vim/undo"
mkdir -p "$HOME/.vim/bundle"

link "$HOME/.vim/bundle/vundle" "$SCRIPT_PATH/vim/bundle/vundle"
link "$HOME/.vimrc" "$SCRIPT_PATH//vim/vimrc"
link "$HOME/.gvimrc" "$SCRIPT_PATH/vim/gvimrc"

# xmonad

mkdir -p "$HOME/.xmonad"

link "$HOME/.xmonad/xmonad.hs" "$SCRIPT_PATH/xmonad/xmonad.hs"
