source ~/.zsh_plugins.sh

stty -ixon

[[ -s "$HOME/.opam/opam-init/init.zsh" ]] && source "$HOME/.opam/opam-init/init.zsh"

[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

[[ -s "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
