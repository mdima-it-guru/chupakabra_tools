# -*- encoding : utf-8 -*-
module ChupakabraTools
	module Extensions
		module Models
			class DataFilter

				def initialize(name, options = {})
					options ||= {}


					self.name = name # **  SETTING NAME  **
					self.css_span = options[:span].to_s if options[:span] # **  SETTING SPAN  **
					self.css_class = options[:class].to_s if options[:class] # **  SETTING CLASS  **
					self.input_type = options[:input_type] || :text_edit # **  SETTING INPUT TYPE  **
					self.filter_name = options[:filter_name] # **  SETTING INPUT TYPE  **
					self.placeholder = options[:placeholder] # **  SETTING PLACEHOLDER  **
					self.label = options[:label] # **  SETTING LABEL  **
					self.parent = options[:parent] # **  SETTING PARENT  **
					self.source = options[:source] # **  SETTING SOURCE  **
					self.source_url = options[:source_url] # **  SETTING SOURCE URL  **


					# ******************* SETTING MASS ASSIGNMENT *****************************
					if options[:mass_assignment].is_a?(Array)
						options[:mass_assignment].each do |ma_val|
							unless [:create, :update, :in_place].include?(ma_val)
								raise "FORM PROPERTY ERROR\r\nForm Property: \"#{name}\".\r\nValue \"#{ma_val}\" is not allowed for array of values of \"mass_assignment\" option"
							end
							if options[:mass_assignment].include?(ma_val)
								raise "FORM PROPERTY ERROR\r\nForm Property: \"#{name}\".\r\nDuplicate value \"#{ma_val}\" in array of values of \"mass_assignment\" option"
							end
							self.mass_assignment.push(ma_val)
						end
					else
						if options[:mass_assignment] == :all
							[:create, :update, :in_place].each do |ma|
								self.mass_assignment.push(ma)
							end
						elsif options[:mass_assignment] == :none

						elsif [:create, :update, :in_place].include?(options[:mass_assignment])
							self.mass_assignment.push(options[:mass_assignment])
						else
							if options[:mass_assignment]
								raise "FORM PROPERTY ERROR\r\nForm Property \"#{name}\".\r\nValue \"#{options[:mass_assignment]}\" is not allowed for \"mass_assignment\" option"
							else
								options[:mass_assignment] = [:create, :update, :in_place]
							end
						end
					end

					#validateing property by input_type
					case self.input_type
						when :chosen_select
							validate_chosen_select
						when :autocomplete_with_id
							validate_autocomplete_with_id
						when :switcher

						when :date_picker

						when :time_picker

						when :image_selector

						when :check_box

						when :radio_button

						when :link

						when :elastic_text_area

						when :text_area

						when :text_edit

						else
							raise "Data Filter: '#{self.name}'\r\nINPUT TYPE #{self.input_type} is not supported at the moment"
					end
					validate_attribute_class # validating class attribute
					validate_attribute_span # validating span attribute
				end


				def name
					@name
				end

				def filter_name
					@filter_name
				end

				def css_span
					@css_span
				end

				def css_class
					@css_class
				end

				def input_type
					@input_type
				end

				def label
					@label
				end

				def placeholder
					@placeholder
				end

				def parent
					@parent
				end

				def source
					@source
				end

				def source_url
					@source_url
				end

				def on_change
					@on_change
				end

				private

				def name= value
					@name = value
				end

				def filter_name= value
					@filter_name = value
				end

				def css_span= value
					@css_span = value
				end

				def css_class= value
					@css_class = value
				end

				def input_type= value
					@input_type = value
				end

				def placeholder= value
					@placeholder = value
				end

				def parent= value
					@parent = value
				end

				def source= value
					@source = value
				end

				def source_url= value
					@source_url = value
				end

				def on_change= value
					@on_change = value
				end

				def label= value
					@label = value
				end

				##################################### DATA FILTER VALIDATIONS FOR CONTROL #####################
				def validate_autocomplete_with_id
					validate_attribute_placeholder #validating placeholder presence
					validate_attribute_onchange #validatting onchange attribute
					validate_attribute_source
				end

				def validate_chosen_select
					validate_attribute_placeholder #validating placeholder presence
					validate_attribute_onchange #validatting onchange attribute
				end

				##################################### DATA FILTER ATTRIBUTE VALIDATIONS #####################
				def validate_attribute_onchange
					if self.on_change

					end
				end

				def validate_attribute_class
					if self.css_class
						unless self.css_class.is_a?(String)
							raise "Data Filter: '#{self.name}'\r\nCLASS attribute is not a String'"
						end
					end
				end

				def validate_attribute_span
					if self.css_span
						unless self.css_span.is_a?(String)
							raise "Data Filter: '#{self.name}'\r\nSPAN attribute is not a String'"
						end
					end
				end

				def validate_attribute_placeholder
					if self.placeholder.nil? || self.placeholder.blank?
						raise "Data Filter '#{self.name}'\r\nPLACEHOLDER missed"
					end
				end

				def validate_attribute_source_url
					unless self.source_url
						raise "Data Filter: '#{self.name}'\r\nSOURCE_URL attribute missed"
					end
				end

				def validate_attribute_source
					unless self.source
						raise "Data Filter: '#{self.name}'\r\nSOURCE attribute missed"
					end
				end

				def validate_attribute_text_value_property()
					unless self.text_value_property
						raise "Data Filter: '#{self.name}'\r\nTEXT_VALUE_PROPERTY attribute missed"
					end
				end
			end
		end
	end
end