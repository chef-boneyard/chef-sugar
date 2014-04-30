require 'spec_helper'

describe Chef::Sugar::RunContext do
  it_behaves_like 'a chef sugar'

  describe '#includes_recipe?' do
    let(:node) { double(Chef::Node) }

    it 'returns true when the recipe exists' do
      node.stub(:run_list).and_return(['recipe[magic::recipe]'])
      included = described_class.includes_recipe?(node, 'recipe[magic::recipe]')
      expect(included).to be_true
    end

    it 'returns false when the recipe does
     not exist' do
      node.stub(:run_list).and_return([])
      included = described_class.includes_recipe?(node, 'recipe[magic::recipe]')
      expect(included).to be_false
    end
  end
end
