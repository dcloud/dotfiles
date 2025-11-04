# Configure gpg, if installed
# ... this is not gpg-suite tools, but gnupg

if [[ -e "$HOMEBREW_PREFIX/bin/gpg" ]]; then
  export GPG_TTY=$(tty);
fi
