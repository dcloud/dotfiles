# dotfiles

All those configuration things.

This was created on a computer running macOS, so many pieces are macOS-specific.

## Installation

1. Clone this repo: `git clone https://github.com/dcloud/dotfiles.git ~/.dotfiles`
1. Make sure you have developer tools installed: `xcode-select --install && sudo xcodebuild -license accept` or install Xcode and run command line tools installer.
1. Install [Homebrew](https://brew.sh)
1. `cd ~/.dotfiles` and run `brew bundle --file=Brewfile.taps`, one for each `Brewfile.*`. You may need to enter your password. Check out individual Brewfiles if you want to see what will be installed.
1. Use `rcm` (should be installed by `Brewfile`) to install the dotfiles: `RCRC=~/.dotfiles/rcrc rcup`
1. Install the [`tmux` plugin manager](https://github.com/tmux-plugins/tpm):
   1. `git clone --depth 1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
   2. `tmux source ~/.tmux.conf`
   3. In a session, run `Ctrl-A` <kbd>I</kbd> (capital I)
1. Create `~/.gitconfig.user` and add your user.name, user.email, etc.
1. Install runtimes using [asdf runtime version manager](https://asdf-vm.com). `asdf plugin <language> <plugin-url>` and `asdf install <language> <version|latest>`. Homebrew may have installed Python and/or other runtimes that formula depend on, but we should use asdf to manage runtimes wherever possible. Check out the [asdf community plugins](https://github.com/asdf-community) for various plugins.

You will probably want to exit your session and begin a new one.

