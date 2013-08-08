module ChupakabraTools
	module Logging
		class StringLogger

			LOG_LEVELS = [:no_log, :fatal, :error, :warning, :info, :debug, :extra_debug]

			def initialize(logger = nil)
				@low_level_logger = logger
				@log_data = []
				@depth = 0
			end

			################### LOGGING METHODS #########################


			def fatal(entry, options = {})
				do_log_entry(:fatal, entry, options) if valid_level?(:fatal, options)
			end

			def error(entry, options = {})
				do_log_entry(:error, entry, options) if valid_level?(:error, options)
			end

			def warning(entry, options = {})
				do_log_entry(:warning, entry, options) if valid_level?(:warning, options)
			end

			def info(entry, options = {})
				do_log_entry(:info, entry, options) if valid_level?(:info, options)
			end

			def debug(entry, options = {})
				do_log_entry(:debug, entry, options) if valid_level?(:debug, options)
			end

			def extra_debug(entry, options = {})
				do_log_entry(:extra_debug, entry, options) if valid_level?(:extra_debug, options)
			end

			################### END OF LOGGING METHODS #########################


			def clear
				@log_data.clear
			end

			def log_data
				@log_data
			end

			def log_as_string
				@log_data.map { |e| e[:data].to_s }.join("\n")
			end

			def log_as_xml
				raise "Not Implemented Yet"
			end

			def log_as_json
				@log_data.to_json
			end

			def depth
				@depth
			end

			def depth_up
				@depth += 1
			end

			def depth_down
				@depth -= 1
				if @depth < 0
					@depth = 0
				end
			end

			def flush
				if @low_level_logger
					@log_data.each do |lg|
						@low_level_logger.info(lg[:data])
					end
				end
				self.clear
			end

			private
			def formatted_log_entry(entry, options = {})
				options ||={}
				(@depth > 0 ? '\t' * @depth : '') + entry
			end

			def do_log_entry(level, entry, options = {})
				options ||={}

				log_entry = {level: level, data: formatted_log_entry(entry, options), time: Time.now.utc }
				log_entry[:host] = options[:host] if options[:host]
				log_entry[:server] = options[:server] if options[:server]
				log_entry[:http_method] = options[:http_method] if options[:http_method]
				log_entry[:user_id] = options[:user_id] if options[:user_id]

				@log_data.push(log_entry)
				self
			end

			def valid_level?(log_method_level, options={})
				return true
				options ||={}
				level = options[:log_level] || :no_log
				case level
					when :no_log
						false
					when :fatal
						[:fatal].include?(log_method_level)
					when :error
						[:fatal, :error].include?(log_method_level)
					when :warning
						[:fatal, :error, :warning].include?(log_method_level)
					when :info
						[:fatal, :error, :warning, :info].include?(log_method_level)
					when :debug
						[:fatal, :error, :warning, :info, :debug].include?(log_method_level)
					when :extra_debug
						true
					else
						false
				end
			end



		end
	end
end

