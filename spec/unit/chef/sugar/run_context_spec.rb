require 'spec_helper'

describe Chef::Sugar::RunContext do
  it_behaves_like 'a chef sugar'

  describe '#includes_recipe?' do
    let(:node) { double(Chef::Node) }

    it 'returns true when the recipe exists' do
      node.stub(:recipe?).and_return(true)
      expect(described_class.includes_recipe?(node, 'foo')).to be_true
    end

    it 'returns false when the recipe does not exist' do
      node.stub(:recipe?).and_return(false)
      expect(described_class.includes_recipe?(node, 'bar')).to be_false
    end
  end
end
