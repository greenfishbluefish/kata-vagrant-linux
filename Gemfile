# -*- mode: ruby -*-
# vi: set ft=ruby :

# This is a Ruby script, with all the capabilities of Ruby. The first two lines,
# or "modelines", set the syntax highlighting for emacs and vim.

# This file is used by Bundler (via "bundle install") to ensure that all the
# necessary Ruby libraries (or "gems") are installed and ready to use.
#
# http://bundler.io/gemfile.html

# rubygems.org is the community-managed repository for opensource Ruby gems. A
# Gemfile can contain multiple sources. Your organization may have a package
# repository where it manages internally-produced gems. Or, your organization
# may choose to mirror gems and prevent direct access to the outside.
#
# If that's the case, then change this line from 'https://rubygems.org' to the
# address of your internal package repository.
#
# This syntax (foo 'value' do ... end) is a Ruby block. This structure is used
# everywhere in literate Ruby code. Vagrant and Chef both use Ruby scripts.
# q.v. http://radar.oreilly.com/2015/09/blocks-in-ruby.html for more details.
source 'https://rubygems.org' do
  # This provides support for the "rake" command which reads the Rakefile
  #
  # https://github.com/ruby/rake
  gem 'rake'

  # This provides the RSpec testing suite.
  #
  # http://rspec.info/
  gem 'rspec'

  # This provides additional testing capabilities geared towards infrastructure
  # validation.
  #
  # http://serverspec.org/
  gem 'serverspec'

  # This provides support for doing SSH commands and management within Ruby. We
  # use it in spec/spec_helper.rb
  gem 'net-ssh'
end
