require 'spec_helper'

describe Chef::Sugar::Docker do
  before(:each) do
    File.stub(:exist?).with("/.dockerenv").and_return(false)
    File.stub(:exist?).with("/.dockerinit").and_return(false)
  end
  it_behaves_like 'a chef sugar'

  describe '#docker?' do
    it 'is true when the file /.dockerenv is present' do
      File.stub(:exist?).with("/.dockerenv").and_return(true)
      node = { 'docker' => nil }
      expect(described_class.docker?(node)).to be true
    end

    it 'is true when the file /.dockerinit is present' do
      File.stub(:exist?).with("/.dockerinit").and_return(true)
      node = { 'docker' => nil }
      expect(described_class.docker?(node)).to be true
    end

    it 'is false when the node is not on cloud' do
      node = { 'docker' => nil }
      expect(described_class.docker?(node)).to be false
    end

  end

end
