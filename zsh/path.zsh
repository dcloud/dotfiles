# paths
# $BREW_PREFIX should be set in zshrc

# Prepend to path if entry does not exist.
# This version from: https://superuser.com/questions/39751/add-directory-to-path-if-its-not-already-there
path_prepend() {
    if [ -d $1 ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="$1${PATH:+":$PATH"}"
    fi
}

#python3
PYTHON3_PATH=/usr/local/opt/python/libexec/bin
path_prepend $PYTHON3_PATH

# haskell
CABAL_BIN=$HOME/.cabal/bin
path_prepend $CABAL_BIN

# jenv for java
JENV_BIN=$HOME/.jenv/bin
path_prepend $JENV_BIN

# MacTex BasicTex http://www.tug.org/mactex/morepackages.html
TEXLIVE_PATH=/Library/TeX/texbin
path_prepend $TEXLIVE_PATH

MACGPG_PATH=/usr/local/MacGPG2/bin
path_prepend $MACGPG_PATH

# Go
# You may wish to add the GOROOT-based install location to your PATH:
# if [[ -d $BREW_PREFIX/opt/go/libexec/bin ]]; then
#   PATH=$PATH:$BREW_PREFIX/opt/go/libexec/bin
# fi
export GOPATH=$HOME/.go
export GOBIN=$GOPATH/bin
path_prepend $GOBIN

# yarn
if hash yarn 2>/dev/null; then
    YARN_PATH=$(yarn global bin)
    path_prepend $YARN_PATH
fi

RUST_PATH=$HOME/.cargo/bin
path_prepend $RUST_PATH

# User path
path_prepend $HOME/.local/bin

export PATH
