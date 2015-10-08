#!/bin/bash

VAGRANT_VERSION=1.7.4

# Install Vagrant
curl -L https://github.com/mitchellh/vagrant/archive/v${VAGRANT_VERSION}.tar.gz -o vagrant.tar.gz
tar zxf vagrant.tar.gz
pushd vagrant-${VAGRANT_VERSION}
bundle config build.nokogiri --use-system-libraries
gem install gssapi -v '1.2.0' --no-document
bundle install
rake install
popd
rm -rf vagrant-${VAGRANT_VERSION}
rm vagrant.tar.gz

# Install vagrant-vsphere
VAGRANT_FORCE_BUNDLER=1 vagrant plugin install vagrant-vsphere

# Cleanup
rm -rf /usr/share/ri
