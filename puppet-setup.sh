#!/usr/bin/env bash

wget https://apt.puppetlabs.com/puppetlabs-release-precise.deb
sudo dpkg -i puppetlabs-release-precise.deb
sudo apt-get update
sudo apt-get install puppet-common
puppet module install jproyo-git
puppet module install jfryman-nginx
