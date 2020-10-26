#!/bin/bash

JAVA_HOME=${JAVA_HOME:-`/usr/libexec/java_home`}
SYSTEM_KEYCHAIN="/Library/Keychains/System.keychain"
KS_PASS=changeit

#find cacerts files
function find_cacerts {
  if [ ! -f ~/.cacerts ]; then
    echo "finding cacerts to update..."
    find / -name cacerts -print 2>/dev/null | grep -v System > ~/.cacerts
    echo
  fi
  echo "~/.cacerts file contains these files:"
  echo
  cat ~/.cacerts
  echo
  echo "Delete ~/.cacerts and rerun script to rescan."
}

#add trusted cert for root cert
function add_trusted_cert_os {
  sudo security add-trusted-cert -d -r trustRoot -k $SYSTEM_KEYCHAIN "$1"
}

#import cert for intermediate cert
function import_cert_os {
  sudo security import "$1" -k /Library/Keychains/System.keychain
}

#install cert in JRE
function install_cert_jre {
  cat ~/.cacerts | while read cacert
  do
    cert_name=$(basename $1)
    echo "deleting alias $cert_name in $cacert:"
    keytool -delete -alias $cert_name -storepass changeit -keystore "$cacert"
    echo
    echo "adding cert alias $cert_name from $1 in $cacert"
    keytool -import -alias $cert_name -file $1 -noprompt -trustcacerts -storepass changeit -keystore "$cacert"
  done
}

#find cacerts in this system
find_cacerts

echo
echo "These certificates found in ~/Downloads folder:"
echo
ls ~/Downloads/*.pem
echo

echo "Enter path to root certificate:"
read root_cert

add_trusted_cert_os $root_cert
install_cert_jre $root_cert

echo "Enter path to intermediate certificate:"
read int_cert

import_cert_os $int_cert
install_cert_jre $int_cert

echo
echo cacerts imported
