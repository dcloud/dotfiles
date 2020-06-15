# wd
# git clone https://github.com/mfaerevaag/wd.git ~/.local/bin/wd
# if wd is installed in ~/.local/bin, set it up

WDPATH="$HOME/.local/bin/wd"

if [[ -d  "$WDPATH" ]]; then
    fpath=($WDPATH $fpath)

    wd() {
        . "$WDPATH/wd.sh"
    }
fi
