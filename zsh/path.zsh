# paths
# $BREW_PREFIX should be set in zshrc

# haskell
if [[ -d $HOME/.cabal/bin ]]; then
  PATH=$HOME/.cabal/bin:$PATH
fi

# MacTex BasicTex http://www.tug.org/mactex/morepackages.html
TEXLIVE_VERSION="2015basic"
if [[ -d $BREW_PREFIX/texlive/$TEXLIVE_VERSION/bin/x86_64-darwin ]]; then
  PATH=$BREW_PREFIX/texlive/$TEXLIVE_VERSION/bin/x86_64-darwin:$PATH
fi

# Go
# You may wish to add the GOROOT-based install location to your PATH:
# if [[ -d $BREW_PREFIX/opt/go/libexec/bin ]]; then
#   PATH=$PATH:$BREW_PREFIX/opt/go/libexec/bin
# fi
export GOPATH=$HOME/.go
if [[ -d $GOPATH/bin ]]; then
  PATH=$GOPATH/bin:$PATH
fi

# User path
if [[ -d $HOME/.local/bin ]]; then
  PATH=$HOME/.local/bin:$PATH
fi

export PATH
