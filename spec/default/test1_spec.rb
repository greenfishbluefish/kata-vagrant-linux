# RSpec is a very expressive way to write tests. All of these files are Ruby
# scripts, just like the Vagrantfile. There is a lot of very good documentation.
# Links:
#   * http://rspec.info/
#   * http://serverspec.org/
describe 'testing' do
  standard_packages = %w(
    ntp
  )
  describe 'Standard packages' do
    describe package 'ntp' do
      it { should be_installed }
    end
  end

  describe 'Purpose 1' do
    describe group 'developers' do
      it { should exist }
    end

    describe user 'john' do
      it { should exist }
      it { should belong_to_primary_group 'developers' }
      it { should belong_to_group 'apache' }
    end

    describe user 'jane' do
      it { should exist }
      it { should belong_to_primary_group 'developers' }
      it { should belong_to_group 'apache' }
    end
  end
end
