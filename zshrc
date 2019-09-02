source ~/.zsh_plugins.sh

stty -ixon

if [[ -s "$HOME/.nvm/nvm.sh" ]]; then
  declare -a NODE_GLOBALS=(`find $HOME/.nvm/versions/node -maxdepth 3 -type l -wholename '*/bin/*' | xargs -n1 basename | sort | uniq`)
  NODE_GLOBALS+=("node")
  NODE_GLOBALS+=("nvm")

  for cmd in "${NODE_GLOBALS[@]}"; do
    eval "${cmd}(){ unset -f ${NODE_GLOBALS}; source $HOME/.nvm/nvm.sh; ${cmd} \$@ }"
  done
fi

[[ -s "$HOME/.opam/opam-init/init.zsh" ]] && source "$HOME/.opam/opam-init/init.zsh"

[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

[[ -s "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
