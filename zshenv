export DEBEMAIL="joonas.javanainen@gmail.com"
export DEBFULLNAME="Joonas Javanainen"

if [[ "$COLORTERM" = "gnome-terminal" ]] && [[ "$TERM" = "xterm" ]]; then
  export TERM=xterm-256color
fi

typeset -U path

pathdirs=(
  "$HOME/.cabal/bin"
  "$HOME/.local/bin"
  "$HOME/bin"
)

for dir in $pathdirs; do
  if [[ -d "$dir" ]]; then
    path=($dir "$path[@]")
  fi  
done

export PATH

[[ -f "$HOME/.zshenv.local" ]] && source "$HOME/.zshenv.local"
