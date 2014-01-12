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

  describe '#namespace' do
    let(:node) { described_class.new }

    it 'defines the attributes' do
      node.instance_eval do
        namespace 'apache2' do
          namespace 'config' do
            root '/var/www'
          end
        end
      end

      expect(node.default).to eq({
        'apache2' => {
          'config' => { 'root' => '/var/www' }
        }
      })
    end

    it 'accepts multiple attributes' do
      node.instance_eval do
        namespace 'apache2', 'config' do
          root '/var/www'
        end
      end

      expect(node.default).to eq({
        'apache2' => {
          'config' => { 'root' => '/var/www' }
        }
      })
    end

    it 'accepts attribute precedence levels' do
      node.instance_eval do
        namespace 'apache2', precedence: normal do
          namespace 'config', precedence: override do
            root '/var/www'
          end
        end
      end

      expect(node.override).to eq({
        'apache2' => {
          'config' => { 'root' => '/var/www' }
        }
      })
    end
  end

end
