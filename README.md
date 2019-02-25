# dotfiles

All those configuration things.

This was created on a computer running macOS, so many pieces are macOS-specific.

## Installation

1. Clone this repo: `git clone https://github.com/dcloud/dotfiles.git ~/.dotfiles`
2. Make sure you have developer tools installed: `xcode-select --install && sudo xcodebuild -license accept` or install Xcode and run command line tools installer.
3. Install [Homebrew](https://brew.sh): `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
4. `cd ~/.dotfiles` and run `brew bundle`. You may need to enter your password. Check out `Brewfile` if you want to see what will be installed.
5. Set up zsh with [Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh): `sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`. Make sure you do this *before* you `rcup` your dotfiles!
6. Use `rcm` (should be installed by `Brewfile`) to install the dotfiles: `rcup -x "README* LICENSE Brewfile iterm2"`
7. Install Atom packages. There are multiple packages files, split up by purpose. You can get a baseline of packages via: `apm install --packages-file ~/.dotfiles/atom/packages-base.txt`
8. Install vim packages: `git submodule update --init --recursive vim/pack/dcloud/start`
9. Install the [`tmux` plugin manager](https://github.com/tmux-plugins/tpm):
    1. `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
    2. `tmux source ~/.tmux.conf`
    3. In a session, run `Ctrl-A` <kbd>I</kbd> (capital I)
10. Create `~/.gitconfig.user` and add your user.name, user.email, etc.

You will probably want to exit your session and begin a new one.

## Updating submodules

Per the [git book chapter on submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules), the simplest way to update submodules is:

```
git submodule update --recursive --remote
```

That will fetch remote changes and merge all of your submodules. You may specify a path if you want to update a single submodule:

```
git submodule update --recursive --remote vim/pack/dcloud/start/vim-airline
```
