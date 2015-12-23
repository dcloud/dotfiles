# Virtualenv config

# Set up PROJECT_HOME so mkproject works
export PROJECT_HOME=$HOME/code/python
# Set WORKON_HOME so virtualenvs have a home
export WORKON_HOME=$HOME/.virtualenvs
# Disable virtualenv prompt override so we can do custom RPS1 instead
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Virtualenvwrapper, lazily
if [[ -f $BREW_PREFIX/bin/virtualenvwrapper.sh ]]; then
    export VIRTUALENVWRAPPER_SCRIPT=$BREW_PREFIX/bin/virtualenvwrapper.sh
    source $BREW_PREFIX/bin/virtualenvwrapper_lazy.sh
fi
