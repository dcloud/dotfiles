function httpless {
    # `httpless example.org'
    http --pretty=all "$@" | less -R;
}

function pynit {
    if [ "x$1" = "x" ]; then
        DIR="./"
    else
        DIR="$1"
    fi
    touch ${DIR}/__init__.py
}
