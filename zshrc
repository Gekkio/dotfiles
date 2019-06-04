source ~/.zsh_plugins.sh

stty -ixon

[[ -f "$HOME/.opam/opam-init/init.zsh" ]] && source "$HOME/.opam/opam-init/init.zsh"

[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
