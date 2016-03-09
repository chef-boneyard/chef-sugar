require 'spec_helper'

describe Chef::Sugar::Virtualization do
  it_behaves_like 'a chef sugar'

  describe '#kvm?' do
    it 'returns true when the machine is under kvm' do
      node = { 'virtualization' => { 'system' => 'kvm' } }
      expect(described_class.kvm?(node)).to be true
    end

    it 'returns false when the virtual machine is not under kvm' do
      node = { 'virtualization' => { 'system' => 'vbox' } }
      expect(described_class.kvm?(node)).to be false
    end

    it 'returns false when the machine is not virtual' do
      node = {}
      expect(described_class.kvm?(node)).to be false
    end
  end

  describe '#lxc?' do
    it 'returns true when the machine is a linux contianer' do
      node = { 'virtualization' => { 'system' => 'lxc' } }
      expect(described_class.lxc?(node)).to be true
    end

    it 'returns false when the virtual machine is not lxc' do
      node = { 'virtualization' => { 'system' => 'vbox' } }
      expect(described_class.lxc?(node)).to be false
    end

    it 'returns false when the machine is not virtual' do
      node = {}
      expect(described_class.lxc?(node)).to be false
    end
  end

  describe '#virtualbox?' do
    it 'returns true when the machine is under virtualbox' do
      node = { 'virtualization' => { 'system' => 'vbox' } }
      expect(described_class.virtualbox?(node)).to be true
    end

    it 'returns false when the virtual machine is not under virtualbox' do
      node = { 'virtualization' => { 'system' => 'kvm' } }
      expect(described_class.virtualbox?(node)).to be false
    end

    it 'returns false when the machine is not virtual' do
      node = {}
      expect(described_class.virtualbox?(node)).to be false
    end
  end

  describe '#vmware?' do
    it 'returns true when the machine is under vmware' do
      node = { 'virtualization' => { 'system' => 'vmware' } }
      expect(described_class.vmware?(node)).to be true
    end

    it 'returns false when the virtual machine is not under vmware' do
      node = { 'virtualization' => { 'system' => 'vbox' } }
      expect(described_class.vmware?(node)).to be false
    end

    it 'returns false when the machine is not virtual' do
      node = {}
      expect(described_class.vmware?(node)).to be false
    end
  end

  describe '#openvz?' do
    it 'returns true when the machine is under openvz' do
      node = { 'virtualization' => { 'system' => 'openvz' } }
      expect(described_class.openvz?(node)).to be true
    end

    it 'returns false when the virtual machine is not under openvz' do
      node = { 'virtualization' => { 'system' => 'kvm' } }
      expect(described_class.openvz?(node)).to be false
    end

    it 'returns false when the machine is not virtual' do
      node = {}
      expect(described_class.openvz?(node)).to be false
    end
  end

  describe '#virtual?' do
    it 'returns true when the machine is under a supported virtualization provider' do
      %w(openvz vmware vbox lxc kvm).each do |host|
        node = { 'virtualization' => { 'system' => host } }
        expect(described_class.virtual?(node)).to be true
      end
    end

    it 'returns false when the machine is not virtual' do
      node = {}
      expect(described_class.virtual?(node)).to be false
    end
  end

  describe '#physical?' do
    it 'returns false when the machine is under a supported virtualization provider' do
      %w(openvz vmware vbox lxc kvm).each do |host|
        node = { 'virtualization' => { 'system' => host } }
        expect(described_class.physical?(node)).to be false
      end
    end

    it 'returns true when the machine is not virtual' do
      node = {}
      expect(described_class.physical?(node)).to be true
    end
  end
end
