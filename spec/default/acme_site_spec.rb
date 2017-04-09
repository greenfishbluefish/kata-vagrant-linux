# The comments in this file assume you've read the comments in apache2_spec.rb.
describe 'ACME site' do
  # We will use let() to define some constants to DRY up our code. (Specs are
  # code and need to be treated with the same care.) A good discussion about why
  # to use let vs. a variable is http://stackoverflow.com/a/5359979/1732954
  let(:username) { 'acme' }
  let(:confdir) { '/etc/apache2' }

  context 'Users and groups' do
    # You can see the username let() here ...
    describe group(username) do
      it { should exist }
    end

    # ... and here ...
    describe user(username) do
      it { should exist }
      # ... and here.
      it { should belong_to_group(username) }
    end
  end

  context 'Apache configuration' do
    # This is the included configuration file for our site in Apache.
    describe file("#{confdir}/sites-available/acme.conf") do
      it { should be_file }
      it { should be_mode('0755') }

      # It's important to note that even if the variable is longer than the
      # string (as it is in this case), this is okay. The reader is able to
      # correlate the various places the same variable is used and be able to
      # skip over what the actual value is. Then, if the value ever changes,
      # maybe through a refactoring, the tests only change in one place. Before
      # you react to "Well, I'd never change a *username* - that's hard!", think
      # about how much easier it is to change things if your servers aren't
      # built by hand, anymore.
      it { should be_owned_by(username) }
      it { should be_grouped_by(username) }
    end

    # The pattern created by the Debian package maintainers is to have the file
    # in sites-available/, then link to it in sites-enabled/. That allows the
    # sysadmin to disable a site quickly without removing files.
    describe file("#{confdir}/sites-enabled/acme.conf") do
      it { should be_linked_to "#{apache_confdir}/sites-available/acme.conf" }
    end
  end

  # But, all of this just verifies that things are in the right places. At the
  # end of the day, the user just cares about the page itself. This is where
  # RSpec truly shines. We can test the server configuration *AND* the server's
  # behavior, all in the same test.
  context 'The web page itself' do
    describe command('curl http://localhost/') do
      its(:stdout) { should be 'Hello from ACME' }
      its(:exit_status) { should eq 0 }
    end
  end
end
