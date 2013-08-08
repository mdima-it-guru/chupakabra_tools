# -*- encoding : utf-8 -*-

module Chupakabratools
	module Extensions
		module Helpers
			module Models
				module Exports

					def export_type(*args)

						options = args.extract_options!
						raise "Filter Property must be defined #{options.to_json}" if name.nil?

						args.each do |arg|
							export_options = {}
							export_options[:name] = arg.to_s.downcase
							export_options[:include] = options[:include]
							get_data_filters_set.push(export_options)
						end
					end

					def export_types_set
						filters = get_data_filters_set
						filters.each do |filter|
							validate_data_filter(filter)
						end
						filters
					end

					def get_data_filters_set
						if defined?(@export_types_set) == false || @export_types_set.nil? || !@export_types_set.is_a?(Array)
							@export_types_set = []
						end
						@export_types_set
					end


					##################################### FORM PROPERTY VALIDATIONS #####################

					private

					def validate_data_filters(properties)
						if Rails.env == 'development'
							if properties && properties.is_a?(Array)
								properties.each do |p|
									validate_data_filter(p)
								end
							end
						end
					end

					def validate_data_filter(property)

						entry = self.new

						#validateing property by input_type
						property_input_type = property[:input_type] || :text_field

						if property_input_type == :chosen_select
							validate_data_filter_chosen_select(property, entry)
						elsif property_input_type == :autocomplete_with_id
							validate_data_filter_autocomplete_with_id(property, entry)
						elsif property_input_type == :switcher

						elsif property_input_type == :date_picker

						elsif property_input_type == :time_picker

						elsif property_input_type == :image_selector

						elsif property_input_type == :check_box

						elsif property_input_type == :radio_button

						elsif property_input_type == :link

						elsif property_input_type == :elastic_text_area


						elsif property_input_type == :text_area

						elsif property_input_type == :text_field

						else
							raise "Current Model Class: #{self}\r\nForm Property '#{property[:name]}'\r\nINPUT TYPE #{property_input_type} is not supported at the moment"
						end

						# validating class attribute
						validate_data_filter_attribute_class(property, entry)
						# validating span attribute
						validate_data_filter_attribute_span(property, entry)
					end

					def validate_data_filter_autocomplete_with_id(property, entry)
						#validateting text_value_property attribute
						validate_data_filter_attribute_text_value_property(property, entry)
						#validating placeholder presense
						validate_data_filter_attribute_placeholder(property, entry)
						#validatting onchange attribute
						validate_data_filter_attribute_onchange(property, entry)


						validate_data_filter_attribute_source(property, entry)
					end

					def validate_data_filter_chosen_select(property, entry)
						#validateting text_value_property attribute
						validate_data_filter_attribute_text_value_property(property, entry)
						#validating placeholder presense
						validate_data_filter_attribute_placeholder(property, entry)
						#validatting onchange attribute
						validate_data_filter_attribute_onchange(property, entry)

					end


					##################################### FORM PROPERTY ATTRIBUTE VALIDATIONS #####################

					def validate_data_filter_attribute_onchange(property, entry)
						if property[:onchange]

						end
					end

					def validate_data_filter_attribute_class(property, entry)
						if property[:class]
							unless property[:class].is_a?(String)
								raise "Current Model Class: #{self}\r\nForm Property '#{property[:name]}'\r\nCLASS attribute is not a String'"
							end
						end
					end

					def validate_data_filter_attribute_span(property, entry)
						if property[:span]
							unless property[:span].is_a?(String)
								raise "Current Model Class: #{self}\r\nForm Property '#{property[:name]}'\r\nSPAN attribute is not a String'"
							end
						end
					end

					def validate_data_filter_attribute_placeholder(property, entry)
						if property[:placeholder].nil? || property[:placeholder].blank?
							raise "Current Model Class: #{self}\r\nForm Property '#{property[:name]}'\r\nPLACEHOLDER missed"
						end
					end

					def validate_data_filter_attribute_text_value_property(property, entry)
						unless property[:text_value_property]
							raise "Current Model Class: #{self}\r\nForm Property '#{property[:name]}'\r\nTEXT_VALUE_PROPERTY attribute missed"
						end

						unless entry.respond_to?(property[:text_value_property])
							raise "Current Model Class: #{self}\r\nForm Property '#{property[:name]}'\r\nTEXT_VALUE_PROPERTY '#{property[:text_value_property]}' method not found for this class"
						end
					end

					def validate_data_filter_attribute_source_url(property, entry)
						unless property[:source_url]
							raise "Current Model Class: #{self}\r\nForm Property '#{property[:name]}'\r\nSOURCE_URL attribute missed"
						end
					end

					def validate_data_filter_attribute_source(property, entry)
						unless property[:source]
							raise "Current Model Class: #{self}\r\nForm Property '#{property[:name]}'\r\nSOURCE attribute missed"
						end
					end
				end
			end
		end
	end
end