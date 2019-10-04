# frozen_string_literal: true

module Facter
  module Resolvers
    class SolarisZone < BaseResolver
      @log = Facter::Log.new
      @semaphore = Mutex.new
      @fact_list ||= {}
      class << self
        def resolve(fact_name)
          @semaphore.synchronize do
            result ||= @fact_list[fact_name]
            subscribe_to_manager
            result || build_zone_fact(fact_name)
          end
        end

        private

        def build_zone_fact(fact_name)
          zone_name_output = CommandUtil.exec_command('/bin/zonename', @log)
          zone_adm_output = CommandUtil.exec_command('/usr/sbin/zoneadm list -cp', @log)
          return unless zone_adm_output || zone_name_output

          zones_result = zone_adm_output.split("\n")
          zones_fact = create_zone_facts(zones_result)
          @fact_list[:zone] = zones_fact
          @fact_list[:current_zone_name] = zone_name_output.chomp
          @fact_list[fact_name]
        end

        def create_zone_facts(zones_result)
          zones_fact = []
          zone_regex_pattern = '(\\d+|-):([^:]*):([^:]*):([^:]*):([^:]*):([^:]*):([^:]*)'
          zones_result.each do |zone_line|
            id, name, status, path, uuid, brand, ip_type = zone_line.match(zone_regex_pattern).captures
            zone_fact = {
              brand: brand,
              id: id,
              ip_type: ip_type.chomp,
              name: name,
              uuid: uuid,
              status: status,
              path: path

            }
            zones_fact << zone_fact
          end
          zones_fact
        end
      end
    end
  end
end
