if hash yarn 2>/dev/null; then
    export PATH="`yarn global bin`:$PATH";
fi
