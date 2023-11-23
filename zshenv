export DEBEMAIL="joonas.javanainen@gmail.com"
export DEBFULLNAME="Joonas Javanainen"

if [[ `whence nvim` ]]; then
  export EDITOR="nvim"
  export VISUAL="nvim"
elif [[ `whence vim` ]]; then
  export EDITOR="vim"
  export VISUAL="vim"
fi

export GPG_TTY=`tty`

if (( ${+DISPLAY} )) && [[ `whence zenity` ]]; then
  export AWS_VAULT_PROMPT=zenity
else
  export AWS_VAULT_PROMPT=terminal
fi
export AWS_VAULT_BACKEND=pass

if [[ -h "$HOME/bin/symlinks/android-sdk" ]]; then
  export ANDROID_HOME=$HOME/bin/symlinks/android-sdk
fi

if [[ -h "$HOME/bin/symlinks/android-ndk" ]]; then
  export ANDROID_NDK_HOME=$HOME/bin/symlinks/android-ndk
fi

typeset -U path

pathdirs=(
  "$HOME/go/bin"
  "$HOME/.cabal/bin"
  "$HOME/.poetry/bin"
  "$HOME/.gem/ruby/2.5.0/bin"
  "$HOME/.gem/ruby/2.3.0/bin"
  "$HOME/bin/symlinks/android-sdk/tools"
  "$HOME/bin/symlinks/android-sdk/platform-tools"
  "$HOME/bin/symlinks/android-ndk"
  "$HOME/bin/symlinks/bsc/bin"
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
