function setjdk() {
  if [ $# -ne 0 ]; then
   removeFromPath '/System/Library/Frameworks/JavaVM.framework/Home/bin'
   if [ -n "${JAVA_HOME+x}" ]; then
    removeFromPath $JAVA_HOME
   fi
   export JAVA_HOME=`/usr/libexec/java_home -v $@`
   export PATH=$JAVA_HOME/bin:$PATH
  fi
  echo $JAVA_HOME
}

function removeFromPath() {
  export PATH=$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")
}

function dotenv() {
     dot_env_path=$(pwd)
     while [[ "$dot_env_path" != "" && ! -e "$dot_env_path/.env" ]]; do
         dot_env_path=${dot_env_path%/*}
     done
 
     # if POETRY_DONT_LOAD_ENV is *not* set, then load .env if it exists
     if [[ -f "$dot_env_path/.env" ]]; then
         >&2 echo 'Loading .env environment variables…'
 
         export $(grep -v '^#' "$dot_env_path/.env"  | tr -d ' ' | xargs)
     fi
}

# Path to your oh-my-zsh installation.
ZSH_DISABLE_COMPFIX=true
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="lukerandall"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# setjdk 11

#if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# node certs
export NODE_EXTRA_CA_CERTS=${HOME}/.dotfiles/nhsbsa-ca/nhsbsa_aws_ca_all.pem

#nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#homebrew
#export PATH="/usr/local/sbin:$PATH"

#local scripts
export PATH="$HOME/.dotfiles/bin:$PATH"

#pipx
export PATH="$HOME/Library/Python/3.9/bin:$PATH"

#poetry
export PATH="$HOME/.local/bin:$PATH"
#alias gitauthors="(base=`pwd`; for d in `find . -name .git | xargs -I % dirname %`; do; cd $d 2>&1 > /dev/null; git --no-pager shortlog -sne | cut -f 2-; cd $base ; done) | sort | uniq"

#openssl
export PATH="${HOMEBREW_PREFIX}/opt/openssl/bin:$PATH"

#Docker
export PATH="$HOME/.docker/bin:$PATH"

#Gvm
[[ -s "/Users/pattu/.gvm/scripts/gvm" ]] && source "/Users/pattu/.gvm/scripts/gvm"

# Add Visual Studio Code (code)
export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"

source "$HOME/.asdf/asdf.sh"
