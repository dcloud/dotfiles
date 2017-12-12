# Since vimrc wants to store viminfo, etc. in ~/.vim/files, make sure it exists

VIMFILES="$HOME/.vim/files"

typeset -a SUBDIRS
SUBDIRS=("backup" "swap" "undo" "info")

if type vim > /dev/null; then
    alias vi=vim
fi


if [[ ! -d $VIMFILES ]]; then
    mkdir -p $VIMFILES;
    for d in $SUBDIRS; do
        mkdir "$VIMFILES/$d";
    done
fi
