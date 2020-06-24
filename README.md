# dotfiles

These are my dotfiles. 

You're welcome to fork the repo, but read the contents and make changes to suit your needs. 
In particular you should change names and email addresses.

## About

This dotfiles folder contains configuration to help set up my working development environment 
in a repeatable way.

It relies on two key utilities:

### Homebrew

[Homebrew](https://brew.sh/) is a package management tool for Mac OSX. Brew allows you to define 
a set of taps, formula and casks in a `Brewfile` that can be installed in one go using `brew bundle`. 
If you want to extract a Brewfile of your current installation just run `brew bundle dump`.

### GNU stow

[GNU stow](https://www.gnu.org/software/stow/) is a tool that lets you define configuration files 
under a sub-folder of your home directory and create symbolic links where the real configuration 
files would normally go.


## Setup

### Generate SSH keys

```
ssh-keygen -t rsa -b 4096 -C "your_email@nhs.net"
```

### Install Brew

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

### Clone this dotfiles repo

```
git clone git@github.com:yantantether/dotfiles.git ~/.dotfiles
```

...and change directory to the `~/.dotfiles` folder before running the next commands

```
cd ~/.dotfiles
```

### Brew bundle to install software

```
brew bundle
```

### Symlink dotfiles with GNU stow

```
stow git m2 zsh
```