# dotfiles

> “I want to say, in all seriousness, that a great deal of harm is being done in the modern world by belief in the virtuousness of work, and that the road to happiness and prosperity lies in an organised diminution of work.”
― Bertrand Russell, In Praise of Idleness and Other Essays

## About

This dotfiles folder contains configuration to help set up my working development environment in a repeatable way.

It relies on two key utilities:

### Homebrew

Homebrew is a package management tool for Mac OSX. Brew allows you to define a set of taps, formula and casks in a `Brewfile` that can be installed in one go using `brew bundle`. If you want to extract a Brewfile of your current installation just run `brew bundle dump`.

### GNU stow

GNU stow is a tool that lets you define configuration files under a sub-folder of your home directory and create symbolic links where the real configuration files would normally go.


## Installation

### Clone this dotfiles repo

```
git clone git@github.com:yantantether/dotfiles.git ~/.dotfiles
```

...and change directory to the `~/.dotfiles` folder before running the next commands

```
cd ~/.dotfiles
```

### Install Brew

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

### Brew bundle to install software

```
brew bundle
```

### Symlink dotfiles with GNU stow

```
stow git m2 zsh
```