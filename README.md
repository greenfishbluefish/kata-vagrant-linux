# Devops kata to learn Vagrant (with Linux)

Devops kata to learn Vagrant with Linux

# Pre-requisites

You have to install:

* RVM (https://rvm.io/rvm/install)
  * Install a minimum of 2.x
* Install Bundler
  * `gem install bundler`
  * Do **NOT** install Bundler globally.
* Install Vagrant (https://www.vagrantup.com/docs/installation/)
* Install Virtualbox (https://www.virtualbox.org/wiki/Downloads)

## Virtualbox and Windows 8/10

If you're on Windows 8.1 or 10 and have enabled Hyper-V (say, for Docker), you
will want to disable Hyper-V and reboot your workstation. While Vagrant does
work with Hyper-V, it is much harder to setup. For learning Vagrant, use the
simplest solution - Virtualbox.

# Instructions

1. Clone this repository
1. bundle install
1. vagrant status
    * You should see 
1. bundle exec rake spec
    * You will see a number of failures.
1. vagrant ssh
    * This will log you into the Ubuntu 14.04 VM.
    * Manually create all the things
    * Re-run the tests (in another terminal) until they pass.
1. vagrant destroy
    * This will destroy the VM
1. Make the tests pass
    * This time, use the provided bash scaffolding
    * Instead of manually creating all the things, put the commands in bash.
    * As you add each command, run "vagrant provision".

# Concepts

There are a lot of concepts going on here.
  
## Idempotency

Most 

# Stretch Goals

* Add a test, see it fail, then make it pass.
