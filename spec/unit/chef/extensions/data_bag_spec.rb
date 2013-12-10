require 'spec_helper'

describe Chef::Sugar::DataBag do
  describe '#encrypted_data_bag_item' do
    before { Chef::EncryptedDataBagItem.stub(:load) }

    it 'loads the encrypted data bag item' do
      expect(Chef::EncryptedDataBagItem).to receive(:load)
        .with('accounts', 'github')

      described_class.encrypted_data_bag_item('accounts', 'github')
    end
  end

  describe '#encrypted_data_bag_item_for_environment' do
    let(:node) { double(:node, chef_environment: 'production') }

    context 'when the environment exists' do
      it 'loads the data from the environment' do
        Chef::EncryptedDataBagItem.stub(:load).and_return(
          'production' => {
            'username' => 'sethvargo',
            'password' => 'bacon',
          }
        )

        expect(described_class.encrypted_data_bag_item_for_environment(node, 'accounts', 'github')).to eq(
          'password' => 'bacon',
          'username' => 'sethvargo',
        )
      end
    end

    context 'when the environment does not exist' do
      it 'loads the data from the default bucket' do
        Chef::EncryptedDataBagItem.stub(:load).and_return(
          'staging' => {
            'username' => 'sethvargo',
            'password' => 'bacon',
          },
          'default' => {
            'username' => 'schisamo',
            'password' => 'ham',
          }
        )

        expect(described_class.encrypted_data_bag_item_for_environment(node, 'accounts', 'github')).to eq(
          'password' => 'ham',
          'username' => 'schisamo',
        )
      end
    end
  end
end
