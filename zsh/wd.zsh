# wd
# git clone https://github.com/mfaerevaag/wd.git ~/.local/wd --depth 1

WDPATH="$HOME/.local/wd"

if [[ -d  "$WDPATH" ]]; then
    WDBIN="$WDPATH/wd.sh"
    wd() {
        . "$WDBIN"
    }
    fpath=($WDPATH $fpath)
    export WD_CONFIG="$HOME/.config/warprc"
fi
