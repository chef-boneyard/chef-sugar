require 'spec_helper'

describe Chef::Sugar::Vagrant do
  it_behaves_like 'a chef sugar'

  describe '#vagrant?' do
    it 'returns true when the machine is on vagrant' do
      node = { 'vagrant' => {} }
      expect(described_class.vagrant?(node)).to be_true
    end

    it 'returns false when the machine is not on vagrant' do
      node = {}
      expect(described_class.vagrant?(node)).to be_false
    end
  end
end
