#
# Copyright 2013-2014, Seth Vargo <sethvargo@gmail.com>
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
    module Vagrant
      extend self

      #
      # Determine if the current node is running in vagrant mode.
      #
      # @param [Chef::Node] node
      #
      # @return [Boolean]
      #   true if the machine is currently running vagrant, false
      #   otherwise
      #
      def vagrant?(node)
        node.key?('vagrant')
      end
    end

    module DSL
      # @see Chef::Sugar::Vagrant#vagrant?
      def vagrant?; Chef::Sugar::Vagrant.vagrant?(node); end
    end
  end
end
