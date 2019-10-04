# frozen_string_literal: true

module Facter
  class CommandUtil
    class << self
      def exec_command(command, logger, log_message = nil)
        raise('Command or logger is not provided as an argument for CommandUtil class') unless command || logger

        output, status = Open3.capture2(command)
        if !status.to_s.include?('exit 0') || output.empty?
          if log_message
            logger.debug(log_message)
          else
            logger.debug "Command: #{command} failed to execute"
          end
          return
        end
        output
      end
    end
  end
end
