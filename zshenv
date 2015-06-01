export DEBEMAIL="joonas.javanainen@gmail.com"
export DEBFULLNAME="Joonas Javanainen"

whence vim &> /dev/null && export EDITOR="vim"

if [[ "$COLORTERM" = "gnome-terminal" ]] || [[ ${$(</proc/$PPID/cmdline):t} == gnome-terminal* ]]; then
  export TERM=xterm-256color
fi

if [[ -h "$HOME/bin/symlinks/android-sdk" ]]; then
  export ANDROID_HOME=$HOME/bin/symlinks/android-sdk
fi

if [[ -h "$HOME/bin/symlinks/android-ndk" ]]; then
  export ANDROID_NDK_HOME=$HOME/bin/symlinks/android-ndk
fi

export NODE_PATH="$HOME/.npm-packages/lib/node_modules:$NODE_PATH"

typeset -U path

pathdirs=(
  "$HOME/.npm-packages/bin"
  "$HOME/.cabal/bin"
  "$HOME/.gem/ruby/2.1.0/bin"
  "$HOME/.gem/ruby/1.9.1/bin"
  "$HOME/bin/symlinks/android-sdk/tools"
  "$HOME/bin/symlinks/android-sdk/platform-tools"
  "$HOME/bin/symlinks/android-ndk"
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
