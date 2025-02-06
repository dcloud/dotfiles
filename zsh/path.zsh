# paths
# Use `$path` array https://zsh.sourceforge.io/Guide/zshguide02.html#l24

# MacTex BasicTex http://www.tug.org/mactex/morepackages.html
TEXLIVE_PATH=/Library/TeX/texbin

MACGPG_PATH=/usr/local/MacGPG2/bin

# User path
USER_PATH=$HOME/.local/bin

# asdf 0.16+
ASDF_PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims"

# Enforce uniqueness
typeset -U path
path=($USER_PATH $ASDF_PATH $MACGPG_PATH $TEXLIVE_PATH $path)
