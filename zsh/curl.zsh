# I want to use the latest curl without causing trouble

CURL_BINDIR="$BREW_PREFIX/opt/curl/bin"

if [[ -d $CURL_BINDIR ]]; then
    alias crl="$CURL_BINDIR/curl"
fi
