# RSpec is a very expressive way to write tests. All of these files are Ruby
# scripts, just like the Vagrantfile. There is a lot of very good documentation.
# Links:
#   * http://rspec.info/
#   * http://serverspec.org/
describe 'testing' do
  describe 'Installed packages' do
    describe package 'ntp' do
      it { should be_installed }
    end
  end

#    it 'has version 9.3 installed' do
#      command('psql -V').stdout.should match(/9.3.\d+/)
#    end

#      cpan_modules.each do |cpan_module|
#        describe command("perl -M#{cpan_module} -e1") do
#          let(:disable_sudo) { true }
#          its(:stderr) { should_not match /^Can't locate/ }
#        end
#      end


#    it "sets the path to the 'cpanm' executable" do
#      command('which cpanm').stdout.chop.should == '/usr/bin/cpanm'
#    end

end
