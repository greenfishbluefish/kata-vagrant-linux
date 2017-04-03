# Devops kata to learn Vagrant (with Linux)

Devops kata to learn Vagrant with Linux

# Pre-requisites

You have to install:

* To clone this repository
    * Install Git (https://git-scm.com/downloads)
    * On Windows, install from git-scm.com - other clients may not be up-to-date
* To run the tests:
    * Install RVM (https://rvm.io/rvm/install)
        * Install the stable RVM
        * Install a minimum Ruby version of 2.x
    * Install Bundler
        * `gem install bundler`
        * Do **NOT** install Bundler globally or with `sudo`.
* Install Vagrant (https://www.vagrantup.com/docs/installation/)
* Install Virtualbox (https://www.virtualbox.org/wiki/Downloads)

## Virtualbox and Windows 8/10

If you're on Windows 8.1 or 10 and have enabled Hyper-V (say, for Docker), you
will want to disable Hyper-V and reboot your workstation. While Vagrant does
work with Hyper-V, it is much harder to setup. For learning Vagrant, use the
simplest solution - Virtualbox.

# Instructions

You will need to use a shell. For Windows, either Powershell, Git-Bash, or the
new Windows 10 Bash shell will work.

1. Clone this repository.
    * Do this on a local drive.
    * Your home directory may be on a network drive.
1. Enter the new directory.
1. Install the necessary Ruby libraries with `bundle install`
1. Look at the current VM status with `vagrant status`
    * You should see something that looks like:
```
Current machine states:

default                   not created (virtualbox)
```
1. Bring the VM up with `vagrant up`
1. Log onto the VM with `vagrant ssh` and walk around, take a look.
    * There is a folder `/vagrant`. This is a shared folder that is linked to
      the folder on the host machine which contains the Vagrantfile.
1. Run the acceptance tests with `bundle exec rake spec`
    * The tests will bring the VM if it's not up yet.
    * You will see a number of failures. These are what you're going to work on.
1. Manually fix the failures.
    * Re-run the tests (in another terminal) until they pass.
    * For example, `sudo apt-get install -y ntp` to fix the first failure.
1. Once all the tests pass, destroy the VM with `vagrant destroy`
    * We're going to recreate it shortly.
1. Run the tests again.
    * This time, instead of making the tests pass manually, you will use the
      provided bash scaffolding.
    * As you add each command, run `vagrant provision` to have them run against
      the VM. Read the below section on Idempotency for how to write them.

# Discussion

There are a lot of moving parts. Every file exists for a purpose and is heavily
commented, explaining what it does and why.

The primary components are:
* The virtualization environment
    * Vagrantfile for the virtualization definition
    * The devops directory for all the devops functionality
* The testing components
    * Gemfile, Gemfile.lock, and .gemrc for installing libraries
    * Rakefile for running tests (Rakefile == 'Ruby Makefile')
    * The spec directory for the tests themselves
* The source control components
    * .gitignore for ensuring temporary files don't get checked in

# Concepts

There are a lot of concepts going on here. Let's break them down, one at a time.

## Virtualization

With Vagrant, you can create a new server in a completely isolated environment.
You can destroy it and create it, over and over, until it's perfect. There are
no links or dependencies on any shared resources, so this work is in a safe
environment.

Unlike the traditional pattern of tweaking a single server over and over until
it's perfect, While this is a great idea in theory, in practice no-one is ever
able to recreate it exactly as it was. There's always a missed step or a change
in version or _something_. And, you will always need to create another copy of
any given server.

Vagrant promotes the pattern of recreating the server from scratch whenever a
change is needed. This enforces the goal that all provisioning steps are done
from scripts and those scripts are committed to source control. Changes to these
scripts are;
1. Done in Vagrant first (an operations development environment)
1. Validated by the development team in _their_ Vagrant-managed development
environments
1. Verified by CI environments using Vagrant to rebuild the servers very time
1. Deployed to QA (and then Production) using the same scripts.
  
## Idempotency

[Definition](https://en.wikipedia.org/wiki/Idempotence#Computer_science_meaning)

Most scripts are written given a known state and performs a set of tasks which
assume that state. In other words, "Do this, then do that."

Idempotent scripts are written with a different mindset. Instead of "Do this,"
the mindset is "Ensure this is done." Scripts written in this way will check for
the completed state and determine which commands are necessary to ensure the
final state is achieved.

This is sometimes called "Desired State".

Many systems administration commands are already idempotent, such as most
package managers like APT and Yum, and the `service` command.

A simple way of ensuring idempotency is to delete the resource (if it exists),
then create it from scratch. This is often used for configuration files. 

# Stretch Goals

* Add a test, see it fail, then make it pass.
