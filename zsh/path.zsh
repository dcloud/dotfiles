# paths
# $BREW_PREFIX should be set in zshrc

# Prepend to path if entry does not exist.
# This version from: https://superuser.com/questions/39751/add-directory-to-path-if-its-not-already-there
path_prepend() {
    if [ -d $1 ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="$1${PATH:+":$PATH"}"
    fi
}

# haskell
CABAL_BIN=$HOME/.cabal/bin
if [[ -d $CABAL_BIN && ":$PATH:" != *":$CABAL_BIN:"* ]]; then
  PATH=$CABAL_BIN:$PATH
fi

# MacTex BasicTex http://www.tug.org/mactex/morepackages.html
TEXLIVE_PATH=/Library/TeX/texbin
if [[ -d $TEXLIVE_PATH && ":$PATH:" != *":$TEXLIVE_PATH:"* ]]; then
  PATH=$TEXLIVE_PATH:$PATH
fi

# Go
# You may wish to add the GOROOT-based install location to your PATH:
# if [[ -d $BREW_PREFIX/opt/go/libexec/bin ]]; then
#   PATH=$PATH:$BREW_PREFIX/opt/go/libexec/bin
# fi
export GOPATH=$HOME/.go
path_prepend $GOPATH/bin

# yarn
if hash yarn 2>/dev/null; then
    YARN_PATH=$(yarn global bin)
    path_prepend $YARN_PATH
fi

# User path
path_prepend $HOME/.local/bin

export PATH
