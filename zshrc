# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

if [ -e "$ZSH" ]; then
  # Set name of the theme to load.
  # Look in ~/.oh-my-zsh/themes/
  # Optionally, if you set this to "random", it'll load a random theme each
  # time that oh-my-zsh is loaded.
  ZSH_THEME="nicoulaj"

  # Example aliases
  # alias zshconfig="mate ~/.zshrc"
  # alias ohmyzsh="mate ~/.oh-my-zsh"

  # Set to this to use case-sensitive completion
  # CASE_SENSITIVE="true"

  # Comment this out to disable bi-weekly auto-update checks
  # DISABLE_AUTO_UPDATE="true"

  # Uncomment to change how often before auto-updates occur? (in days)
  # export UPDATE_ZSH_DAYS=13

  # Uncomment following line if you want to disable colors in ls
  # DISABLE_LS_COLORS="true"

  # Uncomment following line if you want to disable autosetting terminal title.
  # DISABLE_AUTO_TITLE="true"

  # Uncomment following line if you want to disable command autocorrection
  # DISABLE_CORRECTION="true"

  # Uncomment following line if you want red dots to be displayed while waiting for completion
  # COMPLETION_WAITING_DOTS="true"

  # Uncomment following line if you want to disable marking untracked files under
  # VCS as dirty. This makes repository status check for large repositories much,
  # much faster.
  # DISABLE_UNTRACKED_FILES_DIRTY="true"

  # Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
  # Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
  # Example format: plugins=(rails git textmate ruby lighthouse)
  plugins=(command-not-found)

  add_if_exists() {
    while [ "$1" ]; do
      whence "$1" &> /dev/null && plugins+="$1"
      shift
    done
  }
  add_if_exists ant bower cabal git grunt mvn npm sbt scala tmux vagrant

  source $ZSH/oh-my-zsh.sh
fi

[[ -f "$HOME/.opam/opam-init/init.zsh" ]] && source "$HOME/.opam/opam-init/init.zsh"

[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
