# -*- encoding : utf-8 -*-
module ChupakabraTools
	module Extensions
		module Helpers
			module Models
				module StandardActions

					def standard_action(*args)
						options = args.extract_options!
						args.each do |arg|
							if arg && (arg.is_a?(Symbol) || arg.is_a?(String))
								standard_actions_set.push(arg.to_s)
							end
						end

						if options[:disable_all] && options[:disable_all] == true
							@disable_all = true
						else
							@disable_all = false
						end
					end

					def standard_actions_set
						if defined?(@allow_portal_actions_set) == false || @allow_portal_actions_set.nil? || !@allow_portal_actions_set.is_a?(Array)
							@allow_portal_actions_set = []
						end
						@allow_portal_actions_set
					end

					def standard_action_allowed?(action)
						#raise  standard_actions_set.to_json
						#raise action

						unless action && (action.is_a?(Symbol) || action.is_a?(String))
							return false
						end

						if standard_actions_set.count > 0
							standard_actions_set.include?(action.to_s)
						else
							true
						end
					end

					def disable_all_standard_actions?
						@disable_all == true
					end

				end
			end
		end
	end
end

