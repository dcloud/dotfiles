# dotfiles

All those configuration things.

This was created on a computer running macOS, so many pieces are macOS-specific.

## Installation

1. Clone this repo: `git clone https://github.com/dcloud/dotfiles.git ~/.dotfiles`
2. Make sure you have developer tools installed: `xcode-select --install && sudo xcodebuild -license accept` or install Xcode and run command line tools installer.
3. Install [Homebrew](https://brew.sh): `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
4. `cd ~/.dotfiles` and run `brew bundle`. You may need to enter your password. Check out `Brewfile` if you want to see what will be installed.
5. Set up zsh with [Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh): `sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`. Make sure you do this *before* you `rcup` your dotfiles!
6. Use `rcm` (should be installed by `Brewfile`) to install the dotfiles: `rcup -x "README* LICENSE Brewfile sublime iterm2"`
7. Install Atom packages. There are multiple packages files, split up by purpose. You can get a baseline of packages via: `apm install --packages-file ~/.dotfiles/atom/packages-base.txt`
8. Set up [Vundle](https://github.com/VundleVim/Vundle.vim) for VIM:
    1. `git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
    2. `vim +PluginInstall +qall`
9. Install the [`tmux` plugin manager](https://github.com/tmux-plugins/tpm):
    1. `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
    2. `tmux source ~/.tmux.conf`
    3. In a session, run `Ctrl-A` <kbd>I</kbd> (capital I)
10. Create `~/.gitconfig.user` and add your user.name, user.email, etc.

You will probably want to exit your session and begin a new one.
