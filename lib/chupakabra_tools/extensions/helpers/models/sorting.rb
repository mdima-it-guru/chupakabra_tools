# -*- encoding : utf-8 -*-

module ChupakabraTools
	module Extensions
		module Helpers
			module Models
				module Sorting

					def self.included(base)
						base.class_eval do
							include InstanceMethods
						end
					end

					module ClassMethods
						def default_sort_field
							defined?(@default_sort_field) ? @default_sort_field : nil
						end

						def default_sort_field= value
							if value
								@default_sort_field = value.to_s
							else
								@default_sort_field = nil
							end
						end

						def allowed_fields_to_sort
							unless defined?(@allowed_fields_to_sort)
								@allowed_fields_to_sort = []
							end
							@allowed_fields_to_sort
						end

						def allowed_fields_to_sort= value
							@allowed_fields_to_sort = []
							if value
								if value.is_a?(Array)
									value.each do |i|
										@allowed_fields_to_sort.push i.to_s
									end
								else
									@allowed_fields_to_sort.push value.to_s
								end
							end
						end

						def sanitize_sort_order(sort_order = nil)
							return 'asc' if  sort_order.nil? || sort_order.empty?
							return 'asc' if sort_order.to_s.downcase == 'asc'
							return 'desc' if sort_order.to_s.downcase == 'desc'
							'asc'
						end

						def invert_sort_order(sort_order = nil)
							sort_order ||= ""
							sort_order = sort_order.to_s

							return 'desc' if  sort_order.empty?

							sort_order = sanitize_sortorder(sort_order)

							return 'desc' if sort_order == 'asc'
							'asc'
						end
					end

					module InstanceMethods
						def sanitize_sort_by(sort_by)
							sanitized_value = nil

							if self.class.respond_to?(:allowed_fields_to_sort)
								unless sort_by.nil?
									sort_by = sort_by.to_s
									unless  sort_by.empty?
										fields_to_sort = self.allowed_fields_to_sort
										fields_to_sort.each do |fts|
											if fts.downcase == sort_by
												if self.attributes.keys.include?(sort_by)
													sanitized_value = sort_by.downcase
													break
												end
											end
										end
									end
								end
							end
							unless sanitized_value
								if self.class.respond_to?(:default_sort_field)
									if self.attributes.keys.include?(:default_sort_field)
										sanitized_value = self.default_sort_field
									end
								end
							end

							sanitized_value || "id"
						end
					end
				end
			end
		end
	end
end

