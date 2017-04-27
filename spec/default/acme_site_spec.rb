# The comments in this file assume you've read the comments in apache2_spec.rb.
describe 'ACME site' do
  context 'Users and groups' do
    describe group('acme') do
      it { should exist }
    end

    describe user('acme') do
      it { should exist }
      it { should belong_to_group('acme') }
    end
  end

  context 'Apache configuration' do
    # This is the included configuration file for our site in Apache.
    describe file("/etc/apache2/sites-available/acme.conf") do
      it { should be_file }
      it { should be_mode('644') }
      it { should be_owned_by('root') }
      it { should be_grouped_into('root') }
    end

    # The pattern created by the Debian package maintainers is to have the file
    # in sites-available/, then link to it in sites-enabled/. That allows the
    # sysadmin to disable a site quickly without removing files.
    describe file("/etc/apache2/sites-enabled/acme.conf") do
      it { should be_linked_to "../sites-available/acme.conf" }
    end
  end

  context 'The ACME site' do
    describe file("/var/www/acme") do
      it { should be_directory }
      it { should be_mode('755') }
      it { should be_owned_by('acme') }
      it { should be_grouped_into('acme') }
    end

    describe file("/var/www/acme/index.html") do
      it { should be_file }
      it { should be_mode('644') }
      it { should be_owned_by('acme') }
      it { should be_grouped_into('acme') }

      # Testing the content of a file can be tricky. Using contain() and match()
      # should be done judiciously. Just verify the things that are important
      # and ignore everything else.
      its(:content) { should contain('Hello from ACME') }
    end
  end

  # But, all of this just verifies that things are in the right places. At the
  # end of the day, the user just cares about the page itself. This is where
  # RSpec truly shines. We can test the server configuration *AND* the server's
  # behavior, all in the same test.
  context 'The web page itself' do
    # There are many ways of getting a webpage within RSpec and Ruby, such as
    # Capybara, Faraday, and others. However, running a command on the server
    # itself is the cheapest and simplest solution.
    describe command('curl http://acme.dev/') do
      its(:exit_status) { should eq 0 }

      # This is saying "Somewhere in the stdout, I should see this string."
      its(:stdout) { should contain "Hello from ACME" }

      # If you want to compare the complete string, you have to add all the
      # newlines.
      its(:stdout) { should eql "Hello from ACME\n" }
    end
  end
end
