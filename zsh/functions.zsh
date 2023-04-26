function httpless {
    # `httpless example.org'
    http --pretty=all --verbose "$@" | less -R;
}

# mdls is a macOS application for listing file metadata attributes
# mdid for easily getting bundle identifiers, useful with `open` cmd
function mdid() {
    if [[ -e "$1" ]]; then
        cmd="mdls -raw -attr kMDItemCFBundleIdentifier \"$1\"";
        echo -e "\e[2m$cmd\e[0m";
        eval "$cmd";
        echo;
    else
        echo "Please supply a filepath as an argument";
    fi
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
    cmd="lsof -i -P :$1 -n"
    echo -e "\e[2m$cmd\e[0m"
    lsof -i -P -n | grep LISTEN | grep :$1
    local exitcode=$?
    if [ $exitcode -ne 0 ]; then
        echo "Nothing listening on port $1";
    fi
    return $exitcode;
}
