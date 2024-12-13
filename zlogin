mkdir -p "$HOME/.local/share/zsh/site-functions"

[[ `whence mise` ]] && mise completion zsh > "$HOME/.local/share/zsh/site-functions/_mise"

[[ -s "$HOME/.zlogin.local" ]] && source "$HOME/.zlogin.local"

true
