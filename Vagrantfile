# -*- mode: ruby -*-
# vi: set ft=ruby :

# This is a Ruby script, with all the capabilities of Ruby. The first two lines,
# or "modelines", set the syntax highlighting for emacs and vim.

# Specify a minimum Vagrant version everyone using this Vagrantfile must use.
Vagrant.require_version('>= 1.9.0')

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure('2') do |config|
  # q.v. https://www.vagrantup.com/docs/virtualbox/
  config.vm.provider :virtualbox do |vb, override|
    override.vm.box = 'ubuntu/trusty64'

    vb.cpus = 1
    vb.memory = 2 * 1024 # This is denominated in MB, so 2GB
  end

  # q.v. https://www.vagrantup.com/docs/provisioning/shell.html
  config.vm.provision :shell,
    inline: 'echo I am provisioning'

  config.vm.provision :shell,
    path: 'devops/scripts/script1.sh'
end
