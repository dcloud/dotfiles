# wd
# git clone https://github.com/mfaerevaag/wd.git ~/.local/wd --depth 1

WDPATH="$HOME/.local/wd"

if [[ -d  "$WDPATH" ]]; then
    wd() {
        . "$WDPATH/wd.sh"
    }
fi
