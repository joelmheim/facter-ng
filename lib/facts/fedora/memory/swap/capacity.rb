# frozen_string_literal: true

module Facter
  module Fedora
    class MemorySwapCapacity
      FACT_NAME = 'memory.swap.capacity'

      def call_the_resolver
        fact_value = Resolvers::Linux::Memory.resolve(:scapacity)
        fact_value = BytesToHumanReadable.convert(fact_value)
        ResolvedFact.new(FACT_NAME, fact_value)
      end
    end
  end
end
