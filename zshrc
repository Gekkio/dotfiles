source ~/.cache/znap/zsh-snap/znap.zsh

znap prompt sindresorhus/pure

znap source zsh-users/zsh-completions
znap source zsh-users/zsh-autosuggestions
znap source mafredri/zsh-async
znap source ohmyzsh/ohmyzsh lib/{cli,completion,git,history,key-bindings,theme-and-appearance}

stty -ixon

if [[ -s "$HOME/.nvm/nvm.sh" ]] && [[ -s "$HOME/.nvm/versions/node" ]]; then
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

true
