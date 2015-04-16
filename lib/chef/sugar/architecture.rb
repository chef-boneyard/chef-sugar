#
# Copyright 2013-2015, Seth Vargo <sethvargo@gmail.com>
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
    module Architecture
      extend self

      #
      # Determine if the current architecture is 64-bit
      #
      # @return [Boolean]
      #
      def _64_bit?(node)
        %w(amd64 x86_64 ppc64 ppc64le s390x ia64 sparc64 aarch64 arch64 arm64 sun4v sun4u)
          .include?(node['kernel']['machine'])
      end

      #
      # Determine if the current architecture is 32-bit
      #
      # @todo Make this more than "not 64-bit"
      #
      # @return [Boolean]
      #
      def _32_bit?(node)
        !_64_bit?(node)
      end

      #
      # Determine if the current architecture is i386
      #
      # @return [Boolean]
      #
      def i386?(node)
        _32_bit?(node) && intel?(node)
      end

      #
      # Determine if the current architecture is Intel.
      #
      # @return [Boolean]
      #
      def intel?(node)
        %w(i86pc i386 x86_64 amd64 i686)
          .include?(node['kernel']['machine'])
      end

      #
      # Determine if the current architecture is SPARC.
      #
      # @return [Boolean]
      #
      def sparc?(node)
        %w(sun4u sun4v)
          .include?(node['kernel']['machine'])
      end

      #
      # Determine if the current architecture is Powerpc64 Big Endian
      #
      # @return [Boolean]
      #
      def ppc64?(node)
        %w(ppc64)
          .include?(node['kernel']['machine'])
      end

      #
      # Determine if the current architecture is Powerpc64 Little Endian
      #
      # @return [Boolean]
      #
      def ppc64le?(node)
        %w(ppc64le)
          .include?(node['kernel']['machine'])
      end
    end

    module DSL
      # @see Chef::Sugar::Architecture#_64_bit?
      def _64_bit?; Chef::Sugar::Architecture._64_bit?(node); end

      # @see Chef::Sugar::Architecture#_32_bit?
      def _32_bit?; Chef::Sugar::Architecture._32_bit?(node); end
      alias_method :i386?, :_32_bit?

      # @see Chef::Sugar::Architecture#intel?
      def intel?; Chef::Sugar::Architecture.intel?(node); end

      # @see Chef::Sugar::Architecture#sparc?
      def sparc?; Chef::Sugar::Architecture.sparc?(node); end

      # @see Chef::Sugar::Architecture#ppc64?
      def ppc64?; Chef::Sugar::Architecture.ppc64?(node); end

      # @see Chef::Sugar::Architecture#ppc64le?
      def ppc64le?; Chef::Sugar::Architecture.ppc64le?(node); end
    end
  end
end
