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

function _update_completion -a cmd
    set -l completion_file ~/.config/fish/completions/$cmd.fish
    if not command -q $cmd
        return
    end
    if test -f $completion_file; and not test (command -v $cmd) -nt $completion_file
        return
    end
    $argv[2..] > $completion_file
end

if status --is-login
    mkdir -p ~/.config/fish/completions

    _update_completion mise mise completion fish
    _update_completion rg rg --generate=complete-fish
    _update_completion jj env COMPLETE=fish jj
    _update_completion just just --completions fish
    _update_completion zola zola completion fish
end

set -l pathdirs \
    ~/bin/packages/android-sdk/emulator \
    ~/bin/packages/android-sdk/platform-tools \
    ~/bin/packages/oss-cad-suite/bin \
    ~/bin/symlinks/android-build-tools \
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
