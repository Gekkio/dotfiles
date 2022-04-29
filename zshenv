export DEBEMAIL="joonas.javanainen@gmail.com"
export DEBFULLNAME="Joonas Javanainen"

whence vim &> /dev/null && export EDITOR="vim"; export VISUAL="vim"

export GPG_TTY=`tty`

if [[ "$COLORTERM" = "gnome-terminal" ]] || [[ ${$(</proc/$PPID/cmdline):t} == gnome-terminal* ]]; then
  export TERM=xterm-256color
fi

if [[ -h "$HOME/bin/symlinks/android-sdk" ]]; then
  export ANDROID_HOME=$HOME/bin/symlinks/android-sdk
fi

if [[ -h "$HOME/bin/symlinks/android-ndk" ]]; then
  export ANDROID_NDK_HOME=$HOME/bin/symlinks/android-ndk
fi

typeset -U path

pathdirs=(
  "$HOME/go/bin"
  "$HOME/.yarn/bin"
  "$HOME/.cabal/bin"
  "$HOME/.poetry/bin"
  "$HOME/.gem/ruby/2.5.0/bin"
  "$HOME/.gem/ruby/2.3.0/bin"
  "$HOME/bin/symlinks/android-sdk/tools"
  "$HOME/bin/symlinks/android-sdk/platform-tools"
  "$HOME/bin/symlinks/android-ndk"
  "$HOME/bin/packages/oss-cad-suite/bin"
  "$HOME/.cargo/bin"
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
