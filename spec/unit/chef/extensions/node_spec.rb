require 'spec_helper'

describe Chef::Node do
  describe '#in?' do
    it 'returns true when the node is in the environment' do
      subject.stub(:chef_environment).and_return('production')
      expect(subject.in?('production')).to be_true
      expect(subject.in?(/production$/)).to be_true
    end

    it 'returns false when the node is not in the environment' do
      subject.stub(:chef_environment).and_return('staging')
      expect(subject.in?('production')).to be_false
      expect(subject.in?(/production$/)).to be_false
    end
  end

  describe '#includes_recipe?' do
    it 'returns true when the recipe exists' do
      subject.stub(:run_list).and_return(['recipe[magic::recipe]'])
      expect(subject.includes_recipe?('recipe[magic::recipe]')).to be_true
    end

    it 'returns false when the recipe does
     not exist' do
      subject.stub(:run_list).and_return([])
      expect(subject.includes_recipe?('recipe[magic::recipe]')).to be_false
    end
  end
end
