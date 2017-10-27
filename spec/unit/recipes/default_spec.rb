require 'spec_helper'

describe 'chef-sugar::default' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04').converge(described_recipe) }

  it 'converges successfully' do
    expect { :chef_run }.to_not raise_error
  end
end
