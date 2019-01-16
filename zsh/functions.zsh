function httpless {
    # `httpless example.org'
    http --pretty=all --verbose "$@" | less -R;
}

function pynit {
    if [ "x$1" = "x" ]; then
        DIR="./"
    else
        DIR="$1"
    fi
    touch ${DIR}/__init__.py
}

# What's running on a port
function wop() {
    cmd="lsof -i -P -n | grep LISTEN | grep :$1"
    echo -e "\e[2mlsof -i -P -n | grep LISTEN | grep :$1\e[0m"
    lsof -i -P -n | grep LISTEN | grep :$1
    local exitcode=$?
    if [ $exitcode -ne 0 ]; then
        echo "Nothing listening on port $1";
    fi
    return $exitcode;
}
