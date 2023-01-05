# Load Antigen
source /usr/local/share/antigen/antigen.zsh

# Load Antigen configurations
antigen init ~/.antigenrc

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

# setjdk 11

#if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# node certs
export NODE_EXTRA_CA_CERTS=/Users/patrick.turner/.npm/nhsbsa_aws_ca_all.pem

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#homebrew
export PATH="/usr/local/sbin:$PATH"

#local scripts
export PATH="$HOME/.dotfiles/bin:$PATH"

#python

#poetry
export PATH="$HOME/.local/bin:$PATH"
#alias gitauthors="(base=`pwd`; for d in `find . -name .git | xargs -I % dirname %`; do; cd $d 2>&1 > /dev/null; git --no-pager shortlog -sne | cut -f 2-; cd $base ; done) | sort | uniq"

. /usr/local/opt/asdf/libexec/asdf.sh
