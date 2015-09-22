#!/bin/bash

# GREG: INIT VARS HERE - allow override
PROV_SLEDGEHAMMER_SIG="1ba2f9b0dc02983bb1db50ba58f10a57267020c7"
PROV_SLEDGEHAMMER_URL="http://opencrowbar.s3-website-us-east-1.amazonaws.com/sledgehammer"
PROV_TFTPROOT="/tftpboot"
PROV_WEBPORT="8091"

# Get sledgehammer
SS=$PROV_SLEDGEHAMMER_SIG
SS_URL=$PROV_SLEDGEHAMMER_URL/$SS
SS_DIR=$PROV_TFTPROOT/sledgehammer/$SS
mkdir -p $SS_DIR
cd $SS_DIR
if [ ! -e $SS_DIR/sha1sums ] ; then
  curl -L -f -O $SS_URL/initrd0.img
  curl -L -f -O $SS_URL/vmlinuz0
  curl -L -f -O $SS_URL/sha1sums
  sha1sum -c sha1sums
fi
cd -

# Make it the discovery image
mkdir -p $PROV_TFTPROOT/discovery
rm -f $PROV_TFTPROOT/discovery/initrd0.img
ln -s  ../sledgehammer/$SS/initrd0.img $PROV_TFTPROOT/discovery/initrd0.img
rm -f $PROV_TFTPROOT/discovery/vmlinuz0
ln -s  ../sledgehammer/$SS/vmlinuz0 $PROV_TFTPROOT/discovery/vmlinuz0
