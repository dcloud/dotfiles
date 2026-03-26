# mdls is a macOS application for listing file metadata attributes
# mdid for easily getting bundle identifiers, useful with `open` cmd
function mdid() {
    if [[ -e "$1" ]]; then
        local cmd=(mdls -raw -attr kMDItemCFBundleIdentifier "$1")
        print "\e[2m${(j: :)${(q-)cmd[@]}}\e[0m"
        "${cmd[@]}"
        echo
    else
        echo "Please supply a filepath as an argument"
    fi
}

# What's running on a port
function wop() {
    local cmd=(lsof -P -i ":$1" -n)
    print "\e[2m${(j: :)${(q-)cmd[@]}}\e[0m"
    "${cmd[@]}"
    local exitcode=$?
    if [[ $exitcode -ne 0 ]]; then
        echo "Nothing listening on port $1"
    fi
    return $exitcode
}
