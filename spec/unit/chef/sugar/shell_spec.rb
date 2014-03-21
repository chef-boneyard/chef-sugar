require 'spec_helper'

describe Chef::Sugar::Shell do
  describe '#which' do
    it 'returns the first executable matching the command' do
      File.stub(:executable?).and_return(false)
      File.stub(:executable?).with('/usr/bin/mongo').and_return(true)
      expect(described_class.which('mongo')).to eq('/usr/bin/mongo')
    end

    it 'returns nil when no command is found' do
      File.stub(:executable?).and_return(false)
      expect(described_class.which('node')).to be_nil
    end
  end

  describe '#dev_null' do
    it 'returns NUL on Windows' do
      node = { 'platform_family' => 'windows' }
      expect(described_class.dev_null(node)).to eq('NUL')
    end

    it 'returns /dev/null on Linux' do
      node = { 'platform_family' => 'debian' }
      expect(described_class.dev_null(node)).to eq('/dev/null')
    end
  end

  describe '#installed?' do
    it 'returns true if the given binary exists' do
      File.stub(:which).and_return(false)
      File.stub(:which).with('/usr/bin/mongo').and_return(true)
      expect(described_class.installed?('mongo')).to be_true
    end

    it 'returns false if the given binary does not exist' do
      File.stub(:executable?).and_return(false)
      expect(described_class.installed?('node')).to be_false
    end
  end

  describe '#installed_at_version?' do
    it 'returns true if the command is installed at the correct version' do
      described_class.stub(:which).and_return(true)
      described_class.stub(:version_for).and_return('1.2.3')
      expect(described_class.installed_at_version?('mongo', '1.2.3')).to be_true
    end

    it 'returns true if the command is installed at the correct version and has additional output' do
      described_class.stub(:which).and_return(true)
      described_class.stub(:version_for).and_return('Mongo DB version 1.2.3. Some other text.')
      expect(described_class.installed_at_version?('mongo', '1.2.3')).to be_true
    end

    it 'returns true if the command is installed at the correct version with a regex' do
      described_class.stub(:which).and_return(true)
      described_class.stub(:version_for).and_return('1.2.3')
      expect(described_class.installed_at_version?('mongo', /1\.2/)).to be_true
    end

    it 'returns false if the command is installed at the wrong version' do
      described_class.stub(:which).and_return(true)
      described_class.stub(:version_for).and_return('1.2.3')
      expect(described_class.installed_at_version?('mongo', '4.5.6')).to be_false
    end

    it 'returns false if the command is not installed' do
      described_class.stub(:which).and_return(nil)
      expect(described_class.installed_at_version?('mongo', '1.0.0')).to be_false
    end
  end

  describe '#version_for' do
    let(:shell_out) { double('shell_out', run_command: nil, error!: nil, stdout: '1.2.3', stderr: 'Oh no!') }
    before { Mixlib::ShellOut.stub(:new).and_return(shell_out) }

    it 'runs the thing in shellout' do
      expect(Mixlib::ShellOut).to receive(:new).with('mongo --version')
      described_class.version_for('mongo')
    end

    it 'returns the combined stdout and stderr' do
      expect(described_class.version_for('mongo')).to eq("1.2.3\nOh no!")
    end
  end
end
