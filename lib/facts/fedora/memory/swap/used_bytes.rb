# frozen_string_literal: true

module Facter
  module Fedora
    class MemorySwapUsedBytes
      FACT_NAME = 'memory.swap.used_bytes'

      def call_the_resolver
        fact_value = Resolvers::Linux::Memory.resolve(:sused_bytes)
        ResolvedFact.new(FACT_NAME, fact_value)
      end
    end
  end
end
