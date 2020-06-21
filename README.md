# dotfiles

> “I want to say, in all seriousness, that a great deal of harm is being done in the modern world by belief in the virtuousness of work, and that the road to happiness and prosperity lies in an organised diminution of work.”
― Bertrand Russell, In Praise of Idleness and Other Essays

## Installation

### Clone this dotfiles repo

```
git clone git@github.com:yantantether/dotfiles.git ~/.dotfiles
cd .dotfiles
```

### Install Brew

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

### Install software packages

```
brew bundle
```

### Symlink dotfiles

```
cd .dotfiles
stow git
```