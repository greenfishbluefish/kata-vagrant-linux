# RSpec is a very expressive way to write tests. All of these files are Ruby
# scripts, just like the Vagrantfile. There is a lot of very good documentation.
# Links:
#   * http://rspec.info/
#   * http://serverspec.org/
describe 'Apache2' do
  # First thing is to verify the package is installed properly.
  context 'Installed packages' do
    describe package('apache2') do
      it { should be_installed }

      # Even though the package specified has a with_version() option, you have
      # to use the *full* package version. Just "2.4.7" would fail here. And, in
      # most cases, the exact version of the package is unimportant. Usually, it
      # is better to verify capabilities and not versions.
      #it { should be_installed.with_version('2.4.7-1ubuntu4.13') }
    end
  end

  # Second thing is to verify the service is functioning properly.
  context 'Running service' do
    # Each of the states the service can be in (enabled vs. running) are
    # different assertions and so are checked separately. The key to think about
    # is when there is a failure, the failure should be as pinpoint as possible.
    # You, as the reader, should be able to immediately hone in on exactly where
    # the problem is. Ideally, you shouldn't have to do any further work to
    # investigate the issue.
    describe service('apache2') do
      it { should be_enabled }
      it { should be_running }
    end

    # Of course, port 80 should be listening. If necessary, you can also verify
    # that a port is listened to on a specific interface (127.0.0.1 or 10.0.0.1
    # or whatever). However, there is currently no matcher for askeing "Is this
    # service listening on this port?"
    describe port('80') do
      it { should be_listening }
    end

    # It's important to note that you can also validate that a port is *not*
    # being listened on. Every matcher can be negated by using "should_not".
    describe port('443') do
      it { should_not be_listening }
    end
  end
end
