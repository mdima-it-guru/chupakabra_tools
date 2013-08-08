# -*- encoding : utf-8 -*-

module ChupakabraTools
	module Extensions
		module Helpers
			module Controllers
				module ObligatoryFilters


					module ClassMethods
						def obligatory_filter(name, options = {})
							options ||= {}
							raise "Filter Property must be defined #{options.to_json}" if name.nil?

							opts = {}.merge(options)

							opts[:name] = name
							obligatory_filters_set.push(opts)
						end


						def obligatory_filters_set
							if defined?(@obligatory_filters_set) == false || @obligatory_filters_set.nil? || !@obligatory_filters_set.is_a?(Array)
								@obligatory_filters_set = []
							end
							@obligatory_filters_set
						end
					end

				end
			end
		end
	end
end
