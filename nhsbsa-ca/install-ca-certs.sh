#!/bin/bash

# download ca and import as trusted
if test -f ~/Downloads/nhsbsa_aws_ca_2019-2029.pem; then
  wget -P ~/Downloads https://bsa2468.atlassian.net/wiki/download/attachments/577994812/nhsbsa_aws_ca_2019-2029.pem
fi
sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain ~/Downloads/nhsbsa_aws_ca_2019-2029.pem

# download intermediate and import
if test -f ~/Downloads/nhsbsa_aws_int_ca_2019-2024.pem; then
  wget -P ~/Downloads https://bsa2468.atlassian.net/wiki/download/attachments/577994812/nhsbsa_aws_int_ca_2019-2024.pem
fi
sudo security import ~/Downloads/nhsbsa_aws_int_ca_2019-2024.pem -k /Library/Keychains/System.keychain

java_home_path=`/usr/libexec/java_home`
sudo keytool -delete -alias nhsbsa.aws.root.ca.cert.pem -keystore "$java_home_path/lib/security/cacerts"
sudo keytool -delete -alias nhsbsa.aws.int.ca.cert.pem -keystore "$java_home_path/lib/security/cacerts"
sudo keytool -importcert -file ~/Downloads/nhsbsa_aws_ca_2019-2029.pem -keystore "$java_home_path/lib/security/cacerts" -alias nhsbsa.aws.root.ca.cert.pem
sudo keytool -importcert -file ~/Downloads/nhsbsa_aws_int_ca_2019-2024.pem -keystore "$java_home_path/lib/security/cacerts" -alias nhsbsa.aws.int.ca.cert.pem

