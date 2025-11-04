# paths
# Use `$path` array https://zsh.sourceforge.io/Guide/zshguide02.html#l24

# MacTex BasicTex http://www.tug.org/mactex/morepackages.html
TEXLIVE_PATH=/Library/TeX/texbin

# User path
USER_PATH=$HOME/.local/bin

# Enforce uniqueness
typeset -U path
path=($USER_PATH $TEXLIVE_PATH $path)
