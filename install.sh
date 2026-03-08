#!/bin/sh
set -e

require_programs() {
  while [ "${1}" ]; do
    if ! command -v "${1}" > /dev/null 2>&1; then
      echo "${1}" must be installed!
      exit 1
    fi
    shift
  done
}

require_programs realpath readlink git curl

SCRIPT_PATH=$(dirname $(realpath -s $0))

# Adds an apt repository if not already present.
# Usage: add_apt_repo <keyring_path> <keyring_url> <sources_file> <sources_content>
add_apt_repo() {
  KEYRING_PATH="$1"
  KEYRING_URL="$2"
  SOURCES_FILE="$3"
  SOURCES_CONTENT="$4"

  if [ ! -f "$SOURCES_FILE" ]; then
    echo "Adding apt repository $SOURCES_FILE"
    echo "  Fetching keyring from $KEYRING_URL -> $KEYRING_PATH"
    sudo install -dm 755 "$(dirname "$KEYRING_PATH")"
    curl -fSs "$KEYRING_URL" | sudo tee "$KEYRING_PATH" > /dev/null
    echo "  Writing $SOURCES_FILE"
    echo "$SOURCES_CONTENT" | sudo tee "$SOURCES_FILE" > /dev/null
    REPOS_ADDED=1
  fi
}

# Adds a PPA if not already present.
# Usage: add_ppa <ppa>  (e.g. fish-shell/release-4)
add_ppa() {
  PPA="$1"
  if ! grep -qr "$PPA" /etc/apt/sources.list.d/ 2>/dev/null; then
    echo "Adding PPA $PPA"
    sudo add-apt-repository -y "ppa:$PPA"
    REPOS_ADDED=1
  fi
}

# mise
add_apt_repo \
  /etc/apt/keyrings/mise-archive-keyring.asc \
  https://mise.jdx.dev/gpg-key.pub \
  /etc/apt/sources.list.d/mise.sources \
  "Types: deb
URIs: https://mise.jdx.dev/deb
Suites: stable
Components: main
Architectures: amd64
Signed-By: /etc/apt/keyrings/mise-archive-keyring.asc"

# fish
add_ppa fish-shell/release-4

if [ -n "$REPOS_ADDED" ]; then
  sudo apt update -y
  sudo apt install -y mise fish
fi

link() {
  TO=`realpath -s "$1"`
  FROM=`realpath -s "$2"`

  if [ ! -h "$TO" ] || [ `readlink "$TO"` != "$FROM" ]; then
    if [ -h "$TO" ] || [ -e "$TO" ]; then
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

mkdir -p "$HOME/.config/wireplumber/main.lua.d"
link "$HOME/.config/wireplumber/main.lua.d/99-disable-ps4-dualshock.lua" "$SCRIPT_PATH/wireplumber/99-disable-ps4-dualshock.lua"

# fish

mkdir -p "$HOME/.config/fish"
link "$HOME/.config/fish/config.fish" "$SCRIPT_PATH/config.fish"

link "$HOME/.config/starship.toml" "$SCRIPT_PATH/starship.toml"

# git

mkdir -p "$HOME/.config/git"
link "$HOME/.config/git/ignore" "$SCRIPT_PATH/git/ignore"

# mise

mkdir -p "$HOME/.config/mise/conf.d"
link "$HOME/.config/mise/conf.d/base.toml" "$SCRIPT_PATH/mise/conf.d/base.toml"

mise install

# jj

if [ "$(whoami)" = "merujoonas" ]; then
  JJ_EMAIL="joonas@merulogic.com"
else
  JJ_EMAIL="joonas.javanainen@gmail.com"
fi

jj config set --user user.name "Joonas Javanainen"
jj config set --user user.email "$JJ_EMAIL"
