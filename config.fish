set -x DEBFULLNAME "Joonas Javanainen"
if test (whoami) = "merujoonas"
    set -x DEBEMAIL "joonas@merulogic.com"
else
    set -x DEBEMAIL "joonas.javanainen@gmail.com"
end

if command -q nvim
    set -x EDITOR "nvim"
    set -x VISUAL "nvim"
else if command -q vim
    set -x EDITOR "vim"
    set -x VISUAL "vim"
end

set -x GPG_TTY (tty)

set -u fish_greeting

if command -q mise
    mise activate fish | source
end

if command -q starship
    starship init fish | source
end

if status --is-login
    mkdir -p ~/.config/fish/completions

    if command -q mise
        mise completion fish > ~/.config/fish/completions/mise.fish
    end
    if command -q rg
        rg --generate=complete-fish > ~/.config/fish/completions/rg.fish
    end
    if command -q jj
        COMPLETE=fish jj > ~/.config/fish/completions/jj.fish
    end
    if command -q just
        just --completions fish > ~/.config/fish/completions/just.fish
    end
    if command -q zola
        zola completion fish > ~/.config/fish/completions/zola.fish
    end
end

set -l pathdirs \
    ~/bin/packages/oss-cad-suite/bin \
    ~/bin/symlinks/bsc/bin \
    ~/.cabal/bin \
    ~/.cargo/bin \
    ~/.poetry/bin \
    ~/.local/bin \
    ~/bin

for pathdir in $pathdirs
    if test -d $pathdir
        fish_add_path $pathdir
    end
end

if test -d "$HOME/bin/packages/android-sdk"
    set -x ANDROID_HOME "$HOME/bin/packages/android-sdk"
end

if test -f "$HOME/.config/fish/config.local.fish"
    source "$HOME/.config/fish/config.local.fish"
end
