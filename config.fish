if status --is-login
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
end

set -x GPG_TTY (tty)

if command -q mise
    mise activate fish | source
    if status --is-login
        mise completion fish > ~/.config/fish/completions/mise.fish
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