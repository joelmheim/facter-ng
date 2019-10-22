# frozen_string_literal: true

module Facter
  module Fedora
    class MemorySystemCapacity
      FACT_NAME = 'memory.system.capacity'

      def call_the_resolver
        fact_value = Resolvers::Linux::Memory.resolve(:memfree)
        fact_value = BytesToHumanReadable.convert(fact_value)
        ResolvedFact.new(FACT_NAME, fact_value)
      end
    end
  end
end
