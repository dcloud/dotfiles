# if wd is installed in ~/.local/bin, set it up

WD_PATH="$HOME/.local/bin/wd/wd.sh"

if [[ -f  "$WD_PATH" ]]; then
    wd() {
        . "$WD_PATH"
    }
fi
