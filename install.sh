#!/bin/sh
set -e

require_programs() {
  while [ "${1}" ]; do
    if [ ! `which "${1}"` ]; then
      echo "${1}" must be installed!
      exit 1
    fi
    shift
  done
}

require_programs realpath readlink git

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

mkdir -p "$HOME/.vim/bundle"
link "$HOME/.vim/vimrc" "$SCRIPT_PATH/vim/vimrc"
link "$HOME/.gvimrc" "$SCRIPT_PATH/vim/gvimrc"

# neovim

mkdir -p "$HOME/.config/nvim"
mkdir -p "$HOME/.local/share/nvim/bundle"
link "$HOME/.config/nvim/init.vim" "$SCRIPT_PATH/vim/vimrc"

# ideavim

mkdir -p "$HOME/.config/ideavim"
link "$HOME/.config/ideavim/ideavimrc" "$SCRIPT_PATH/ideavimrc"

# xmonad

mkdir -p "$HOME/.xmonad"

link "$HOME/.xmonad/xmonad.hs" "$SCRIPT_PATH/xmonad/xmonad.hs"

# GTK

link "$HOME/.config/gtk-3.0/gtk.css" "$SCRIPT_PATH/gtk.css"

# zsh

link "$HOME/.zshenv" "$SCRIPT_PATH/zshenv"
link "$HOME/.zshrc" "$SCRIPT_PATH/zshrc"

mkdir -p $HOME/.cache/znap
if [ ! -e "$HOME/.cache/znap/zsh-snap" ]; then
  git clone --depth 1 https://github.com/marlonrichert/zsh-snap.git "$HOME/.cache/znap/zsh-snap"
fi
