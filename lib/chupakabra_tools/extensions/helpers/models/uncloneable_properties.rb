# -*- encoding : utf-8 -*-
module ChupakabraTools
	module Extensions
		module Helpers
			module Models
				module UncloneableProperties
					def unclonable_property(*args)
						args.each do |arg|
							if self.respond_to?(arg)
								unclonable_properties_set.push(arg.to_s)
							end
						end
					end

					def unclonable_properties_set
						if defined?(@unclonable_properties_set) == false || @unclonable_properties_set.nil? || !@unclonable_properties_set.is_a?(Array)
							@unclonable_properties_set = []
						end
						@unclonable_properties_set
					end
				end
			end
		end
	end
end
