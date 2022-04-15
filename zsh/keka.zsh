# Keka provides a CLI
KEKABIN="/Applications/Keka.app/Contents/MacOS/Keka"

if [[ -f $KEKABIN ]]; then

    keka() {
        if [ $# -eq 0 ]; then
            $KEKABIN -h;
        else
            $KEKABIN "$@";
        fi
    }

fi

