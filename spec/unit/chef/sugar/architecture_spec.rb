require 'spec_helper'

describe Chef::Sugar::Architecture do
  it_behaves_like 'a chef sugar'

  describe '#_64_bit?' do
    %w(x86_64 ppc64 s390x IA64 sparc64 aarch64 arch64 arm64).each do |arch|
      it "returns true when the system is #{arch}" do
        node = { 'kernel' => { 'machine' => arch } }
        expect(described_class._64_bit?(node)).to be true
      end
    end

    it 'returns false when the system is not 64 bit' do
      node = { 'kernel' => { 'machine' => 'i386' } }
      expect(described_class._64_bit?(node)).to be false
    end
  end

  describe '#_32_bit?' do
    it 'returns true when the system is 32 bit' do
      node = { 'kernel' => { 'machine' => 'i386' } }
      expect(described_class._32_bit?(node)).to be true
    end

    it 'returns false when the system is not 32 bit' do
      node = { 'kernel' => { 'machine' => 'x86_64' } }
      expect(described_class._32_bit?(node)).to be false
    end
  end
end
