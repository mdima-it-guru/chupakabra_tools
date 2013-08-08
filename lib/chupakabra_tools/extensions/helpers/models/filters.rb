# -*- encoding : utf-8 -*-

require 'chupakabra_tools/extensions/models/data_filter'

module ChupakabraTools
	module Extensions
		module Helpers
			module Models
				module Filters

					def data_filter(name, options = {})
						options ||= {}
						raise "Filter Property must be defined #{options.to_json}" if name.nil?

						data_filter = ::ChupakabraTools::Extensions::Models::DataFilter.new(name, options)
						get_data_filters_set.push(data_filter)
					end

					def data_filters_set
						get_data_filters_set

					end


					def get_data_filters_set
						if defined?(@data_filters_set) == false || @data_filters_set.nil? || !@data_filters_set.is_a?(Array)
							@data_filters_set = []
						end
						@data_filters_set
					end
				end
			end
		end
	end
end

