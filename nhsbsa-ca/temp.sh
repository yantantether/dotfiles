#!/bin/bash

# remove an aliased cert
function remove_cert_jre {
  cert_pattern=$1
  cat ~/.cacerts | while read cacert
  do
    keytool -v -list -storepass changeit -keystore "$cacert" | grep Alias | awk '{print $3}' | grep -E "$cert_pattern" | while read alias
    do
      echo "deleting alias $alias in $cacert:"
      keytool -delete -alias $alias -storepass changeit -keystore "$cacert"
    done
  done
}

remove_cert_jre nhsbsa
