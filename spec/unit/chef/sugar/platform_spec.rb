require 'spec_helper'

describe Chef::Sugar::Platform do
  it_behaves_like 'a chef sugar'

  describe '#platform_version' do
    it 'returns the platform version' do
      node = { 'platform_version' => '1.2.3' }
      expect(described_class.platform_version(node)).to eq('1.2.3')
    end
  end

  context 'dynamic matchers' do
    describe '#ubuntu_after_lucid?' do
      it 'returns true when the version is later than 10.04' do
        node = { 'platform' => 'ubuntu', 'platform_version' => '10.10' }
        expect(described_class.ubuntu_after_lucid?(node)).to be true
      end

      it 'returns false when the version is 10.04' do
        node = { 'platform' => 'ubuntu', 'platform_version' => '10.04' }
        expect(described_class.ubuntu_after_lucid?(node)).to be false
      end

      it 'returns false when the version is a patch release higher than 10.04' do
        node = { 'platform' => 'ubuntu', 'platform_version' => '10.04.4' }
        expect(described_class.ubuntu_after_lucid?(node)).to be false
      end

      it 'returns false when the version is less than 10.04' do
        node = { 'platform' => 'ubuntu', 'platform_version' => '9.10' }
        expect(described_class.ubuntu_after_lucid?(node)).to be false
      end
    end

    describe '#ubuntu_after_or_at_lucid?' do
      it 'returns true when the version is later than 10.04' do
        node = { 'platform' => 'ubuntu', 'platform_version' => '10.10' }
        expect(described_class.ubuntu_after_or_at_lucid?(node)).to be true
      end

      it 'returns true when the version is 10.04' do
        node = { 'platform' => 'ubuntu', 'platform_version' => '10.04' }
        expect(described_class.ubuntu_after_or_at_lucid?(node)).to be true
      end

      it 'returns true when the version is a patch release higher than 10.04' do
        node = { 'platform' => 'ubuntu', 'platform_version' => '10.04.4' }
        expect(described_class.ubuntu_after_or_at_lucid?(node)).to be true
      end

      it 'returns false when the version is less than 10.04' do
        node = { 'platform' => 'ubuntu', 'platform_version' => '9.10' }
        expect(described_class.ubuntu_after_or_at_lucid?(node)).to be false
      end
    end

    describe '#ubuntu_lucid?' do
      it 'returns false when the version is later than 10.04' do
        node = { 'platform' => 'ubuntu', 'platform_version' => '10.10' }
        expect(described_class.ubuntu_lucid?(node)).to be false
      end

      it 'returns true when the version is 10.04' do
        node = { 'platform' => 'ubuntu', 'platform_version' => '10.04' }
        expect(described_class.ubuntu_lucid?(node)).to be true
      end

      it 'returns true when the version is a patch release higher than 10.04' do
        node = { 'platform' => 'ubuntu', 'platform_version' => '10.04.4' }
        expect(described_class.ubuntu_lucid?(node)).to be true
      end

      it 'returns false when the version is less than 10.04' do
        node = { 'platform' => 'ubuntu', 'platform_version' => '9.10' }
        expect(described_class.ubuntu_lucid?(node)).to be false
      end
    end

    describe '#ubuntu_before_lucid?' do
      it 'returns false when the version is later than 10.04' do
        node = { 'platform' => 'ubuntu', 'platform_version' => '10.10' }
        expect(described_class.ubuntu_before_lucid?(node)).to be false
      end

      it 'returns false when the version is 10.04' do
        node = { 'platform' => 'ubuntu', 'platform_version' => '10.04' }
        expect(described_class.ubuntu_before_lucid?(node)).to be false
      end

      it 'returns false when the version is a patch release higher than 10.04' do
        node = { 'platform' => 'ubuntu', 'platform_version' => '10.04.4' }
        expect(described_class.ubuntu_before_lucid?(node)).to be false
      end

      it 'returns true when the version is less than 10.04' do
        node = { 'platform' => 'ubuntu', 'platform_version' => '9.10' }
        expect(described_class.ubuntu_before_lucid?(node)).to be true
      end
    end

    describe '#ubuntu_before_or_at_lucid?' do
      it 'returns false when the version is later than 10.04' do
        node = { 'platform' => 'ubuntu', 'platform_version' => '10.10' }
        expect(described_class.ubuntu_before_or_at_lucid?(node)).to be false
      end

      it 'returns true when the version is 10.04' do
        node = { 'platform' => 'ubuntu', 'platform_version' => '10.04' }
        expect(described_class.ubuntu_before_or_at_lucid?(node)).to be true
      end

      it 'returns true when the version is a patch release higher than 10.04' do
        node = { 'platform' => 'ubuntu', 'platform_version' => '10.04.4' }
        expect(described_class.ubuntu_before_or_at_lucid?(node)).to be true
      end

      it 'returns true when the version is less than 10.04' do
        node = { 'platform' => 'ubuntu', 'platform_version' => '9.10' }
        expect(described_class.ubuntu_before_or_at_lucid?(node)).to be true
      end
    end

    describe '#centos_final?' do
      it 'returns true when the version is a subset of the major' do
        node = { 'platform' => 'centos', 'platform_version' => '6.8' }
        expect(described_class.centos_final?(node)).to be true
      end

      it 'returns false when the version is not the major' do
        node = { 'platform' => 'centos', 'platform_version' => '7.4' }
        expect(described_class.centos_final?(node)).to be false
      end
    end

    describe '#debian_wheezy?' do
      it 'returns true when the version is a subset of the major' do
        node = { 'platform' => 'debian', 'platform_version' => '7.1' }
        expect(described_class.debian_wheezy?(node)).to be true
      end

      it 'returns false when the version is not the major' do
        node = { 'platform' => 'debian', 'platform_version' => '6.1' }
        expect(described_class.debian_wheezy?(node)).to be false
      end
    end

    describe '#debian_before_wheezy?' do
      it 'returns true when the version is a less than the major' do
        node = { 'platform' => 'debian', 'platform_version' => '6.5' }
        expect(described_class.debian_before_wheezy?(node)).to be true
      end

      it 'returns false when the version is not less than the major' do
        node = { 'platform' => 'debian', 'platform_version' => '8.0' }
        expect(described_class.debian_before_wheezy?(node)).to be false
      end
    end

    describe '#solaris_10?' do
      it 'returns true when the version is 5.10' do
        node = { 'platform' => 'solaris2', 'platform_version' => '5.10' }
        expect(described_class.solaris_10?(node)).to be true
      end
    end

    describe '#solaris_11?' do
      it 'returns true when the version is 5.11' do
        node = { 'platform' => 'solaris2', 'platform_version' => '5.11' }
        expect(described_class.solaris_11?(node)).to be true
      end
    end
  end
end
