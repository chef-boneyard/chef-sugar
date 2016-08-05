require 'spec_helper'

describe Chef::Sugar::Kitchen do
  it_behaves_like 'a chef sugar'

  describe '#kitchen?' do
    it 'is true when the TEST_KITCHEN environment variable is set' do
      ENV['TEST_KITCHEN'] = '1'
      node = {}
      expect(described_class.kitchen?(node)).to be true
    end

    it 'is false when the TEST_KITCHEN environment variable is unset' do
      node = {}
      expect(described_class.kitchen?(node)).to be false
    end
  end
end
