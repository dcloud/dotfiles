# dotfiles

All those configuration things.

This was created on a computer running macOS, so many pieces are macOS-specific.

## Installation

1. Clone this repo: `git clone https://github.com/dcloud/dotfiles.git ~/.dotfiles`
1. Make sure you have developer tools installed: `xcode-select --install && sudo xcodebuild -license accept` or install Xcode and run command line tools installer.
1. Install [Homebrew](https://brew.sh)
1. `brew install rcm pure mise tmux` to get started.
1. Use `rcm` to install the dotfiles: `RCRC=~/.dotfiles/rcrc rcup`
1. Install the [`tmux` plugin manager](https://github.com/tmux-plugins/tpm):
   1. `git clone --depth 1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
   2. `tmux source ~/.tmux.conf`
   3. In a session, run `Ctrl-A` <kbd>I</kbd> (capital I)
1. Create `~/.gitconfig.user` and add your user.name, user.email, etc.
1. Install runtimes using [mise](https://mise.jdx.dev/).

You will probably want to exit your session and begin a new one.


### Other tasks

- Install `wd`. See `zsh/wd.zsh` for details
- Install preferred tools, e.g.:
    - `eza`
    - `bat`
    - `fzf`
    - `rg`
    - `yq`
- Configure treesitter for Neovim
  - `brew install neovim tree-sitter-cli`
  - Open Neovim, pre-selected parsers should install, per config

