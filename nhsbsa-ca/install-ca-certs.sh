#!/bin/bash

JAVA_HOME=${JAVA_HOME:-`/usr/libexec/java_home`}
SYSTEM_KEYCHAIN="/Library/Keychains/System.keychain"
KS_PASS=changeit

# Check if we're root and re-execute if we're not.
rootcheck () {
    if [ $(id -u) != "0" ]
    then
      echo this script must run as root. You may be prompted for your OS password
      sudo "$0" "$@"
      exit $?
    fi
}

# find cacerts files
function find_cacerts {
  echo
  if [ ! -f ~/.cacerts ]; then
    echo "finding cacerts to update..."
    find / -name cacerts -print 2>/dev/null | grep -v System > ~/.cacerts
    echo "scan of system found these 'cacerts' files:"
  else
    echo "previous scan of system found these 'cacerts' files:"
  fi
  echo
  cat ~/.cacerts | sed 's/^/  /'
  echo
  echo "They will be updated with the NHSBSA root and intermediate certificates you provide."
  echo "Delete this cache file and rerun script to rescan:"
  echo
  echo "  rm ~/.cacerts"
}

# find pem certs in Downloads only
function find_certs {
  echo
  echo "These certificates were found in ~/Downloads folder:"
  echo
  ls ~/Downloads/*.pem | sed 's/^/  /'
}

# add trusted cert for root cert
function add_trusted_cert_os {
  sudo security add-trusted-cert -d -r trustRoot -k $SYSTEM_KEYCHAIN "$1"
}

# import cert for intermediate cert
function import_cert_os {
  sudo security import "$1" -k /Library/Keychains/System.keychain
}

# remove an aliased cert
function remove_cert_jre {
  cert_pattern=$1
  cacert=$2
  keytool -v -list -storepass changeit -keystore "$cacert" | grep Alias | awk '{print $3}' | grep "$cert_pattern" | while read alias
  do
    echo "deleting alias $alias in $cacert:"
    keytool -delete -alias $alias -storepass changeit -keystore "$cacert"
  done
}


# remove an aliased cert from all jres
function remove_cert_all_jre {
  cert_pattern=$1
  echo
  echo "checking existing alias matching '$cert_pattern' from all JRE cacert files"
  cat ~/.cacerts | while read cacert
  do
    remove_cert_jre $cert_pattern $cacert
  done
}

# install cert in JRE
function install_cert_jre {
  cert_name=$(basename $1)
  cat ~/.cacerts | while read cacert
  do
    # double check removal by cert filename alias
    remove_cert_jre $cert_name $cacert
    echo
    echo "adding cert alias $cert_name from $1 in $cacert"
    keytool -import -alias $cert_name -file $1 -noprompt -trustcacerts -storepass changeit -keystore "$cacert"
  done
}

# install cert in minikube
function install_cert_minikube {
  if [ -d ~/.minikube ]; then
    echo "adding $1 to minikube certs..."
    echo
    cp $1 ~/.minikube/certs
  fi
}

# force run as root
rootcheck

# find cacerts in this system
find_cacerts

# remove nhsbsa named certs
remove_cert_all_jre nhsbsa

# root cert
find_certs
echo
echo "Enter path to root certificate:"
echo
read root_cert

add_trusted_cert_os $root_cert
install_cert_jre $root_cert
install_cert_minikube $root_cert

# int cert
find_certs
echo
echo "Enter path to intermediate certificate:"
echo
read int_cert

import_cert_os $int_cert
install_cert_jre $int_cert
install_cert_minikube $int_cert

# report back
echo
echo "cacerts imported"
echo

# minikube warning
if [ -d ~/.minikube ]; then
  echo "minukube must be restarted with the --embed-certs flag to sync the certificates:"
  echo
  echo "  minikube start --embed-certs"
  echo
  cp $1 ~/.minikube/certs
fi
