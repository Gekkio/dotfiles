source ~/.cache/znap/zsh-snap/znap.zsh

znap prompt sindresorhus/pure

znap source zsh-users/zsh-completions
znap source zsh-users/zsh-autosuggestions
znap source mafredri/zsh-async
znap source ohmyzsh/ohmyzsh lib/{cli,completion,git,history,key-bindings,theme-and-appearance}

stty -ixon

[[ -s "$HOME/.opam/opam-init/init.zsh" ]] && source "$HOME/.opam/opam-init/init.zsh"

[[ -s "$HOME/.local/share/rtx/bin/rtx" ]] && eval "$(/home/joonas/.local/share/rtx/bin/rtx activate zsh)"

[[ -s "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

true
