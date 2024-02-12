# paths
# Use `$path` array https://zsh.sourceforge.io/Guide/zshguide02.html#l24

# haskell
CABAL_BIN=$HOME/.cabal/bin

# MacTex BasicTex http://www.tug.org/mactex/morepackages.html
TEXLIVE_PATH=/Library/TeX/texbin

MACGPG_PATH=/usr/local/MacGPG2/bin

RUST_PATH=$HOME/.cargo/bin

# User path
USER_PATH=$HOME/.local/bin

# Enforce uniqueness
typeset -U path
path=($USER_PATH $RUST_PATH $MACGPG_PATH $TEXLIVE_PATH $CABAL_BIN $PYTHON3_PATH $path)
