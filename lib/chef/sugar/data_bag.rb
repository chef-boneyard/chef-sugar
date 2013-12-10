#
# Copyright 2013, Seth Vargo <sethvargo@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

class Chef
  module Sugar
    module DataBag
      extend self

      #
      # Helper method for loading an encrypted data bag item in a similar
      # syntax/recipe DSL method.
      #
      # @param [String] bag
      #   the name of the encrypted data bag
      # @param [String] id
      #   the id of the encrypted data bag
      #
      # @return [Hash]
      #
      def encrypted_data_bag_item(bag, id)
        Chef::Log.debug "Loading encrypted data bag item #{bag}/#{id}"
        Chef::EncryptedDataBagItem.load(bag, id)
      end

      #
      # This algorithm attempts to find the data bag entry for the current
      # node's Chef environment. If there are no environment-specific
      # values, the "default" bucket is used. The data bag must follow the
      # schema:
      #
      #   {
      #     "default": {...},
      #     "environment_name": {...},
      #     "other_environment": {...},
      #   }
      #
      # @param [Node] node
      #   the current Chef node
      # @param [String] bag
      #   the name of the encrypted data bag
      # @param [String] id
      #   the id of the encrypted data bag
      #
      # @return [Hash]
      #
      def encrypted_data_bag_item_for_environment(node, bag, id)
        data = encrypted_data_bag_item(bag, id)

        if data[node.chef_environment]
          Chef::Log.debug "Using #{node.chef_environment} as the key"
          data[node.chef_environment]
        else
          Chef::Log.debug "#{node.chef_environment} key does not exist, using `default`"
          data['default']
        end
      end
    end

    module DSL
      # @see Chef::Sugar::DataBag#encrypted_data_bag_item?
      def encrypted_data_bag_item(bag, id)
        Chef::Sugar::DataBag.encrypted_data_bag_item(bag, id)
      end

      # @see Chef::Sugar::DataBag#encrypted_data_bag_item_for_environment?
      def encrypted_data_bag_item_for_environment(bag, id)
        Chef::Sugar::DataBag.encrypted_data_bag_item_for_environment(node, bag, id)
      end
    end
  end
end
