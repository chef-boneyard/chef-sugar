require 'spec_helper'

describe 'chef-sugar::default' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  it 'installs the chef gem' do
    expect(chef_run).to install_chef_gem('chef-sugar')
      .with(version: Chef::Sugar::VERSION)
  end
end
