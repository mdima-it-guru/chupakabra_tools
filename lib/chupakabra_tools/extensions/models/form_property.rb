# -*- encoding : utf-8 -*-
module ChupakabraTools
	module Extensions
		module Models
			class FormProperty

				def initialize(name, klass, options = {})
					options ||= {}


					# ******************* SETTING NAME *************************************
					self.name = name
					# ******************* SETTING SPAN *************************************
					self.css_span = options[:span].to_s if options[:span]
					# ******************* SETTING CLASS *************************************
					self.css_class = options[:class].to_s if options[:class]
					# ******************* SETTING INPUT TYPE *************************************
					self.input_type = options[:input_type] || :text_edit


					# ******************* SETTING TEXT VALUE PROPERTY *************************************
					self.text_value_property = options[:text_value_property]
					# ******************* SETTING PLACEHIOLDER *************************************
					self.placeholder = options[:placeholder]
					# ******************* SETTING PARENT *************************************
					self.parent = options[:parent]
					# ******************* SETTING SOURCE *************************************
					self.source = options[:source]
					# ******************* SETTING IN_PLACE *************************************
					self.in_place = options[:in_place] == true
					# ******************* SETTING EDIT_READ_ONLY *************************************
					self.edit_read_only = options[:edit_read_only] == true
					# ******************* SETTING EDIT_READ_ONLY *************************************
					self.source_url = options[:source_url]
					# ******************* SETTING EDIT_READ_ONLY *************************************
					self.only = options[:only]


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

					entry = klass.new

					validate_attribute_name(entry) # validation property name
					#validateing property by input_type
					case self.input_type
						when :chosen_select
							validate_chosen_select(entry)
						when :autocomplete_with_id
							validate_autocomplete_with_id(entry)
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
							raise "Current Model Class: #{self}\r\nForm Property '#{self.name}'\r\nINPUT TYPE #{self.input_type} is not supported at the moment"

					end
					validate_attribute_class(entry) # validating class attribute
					validate_attribute_span(entry) # validating span attribute
				end


				def name
					@name
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

				def mass_assignment
					@mass_assignment = [] unless @mass_assignment
					@mass_assignment
				end

				def text_value_property
					@text_value_property
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

				def in_place
					@in_place
				end

				def edit_read_only
					@edit_read_only
				end

				def source_url
					@source_url
				end

				def on_change
					@on_change
				end

				def only
					@only
				end

				def predefined_values
					@predefined_values
				end

				def show_pattern
					@show_pattern
				end

				private

				def name= value
					@name = value
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

				def mass_assignment= value
					@mass_assignment = value
				end

				def text_value_property= value
					@text_value_property = value
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

				def in_place= value
					@in_place = value
				end

				def edit_read_only= value
					@edit_read_only = value
				end

				def source_url= value
					@source_url = value
				end

				def on_change= value
					@on_change = value
				end

				def only= value
					@only = value
				end

				def predefined_values= value
					@predefined_values= value
				end

				def show_pattern= value
					@show_pattern = value
				end

				##################################### FORM PROPERTY VALIDATIONS #####################

				def validate_autocomplete_with_id(entry)

					validate_attribute_text_value_property(entry) #validateting text_value_property attribute

					validate_attribute_placeholder(entry) #validating placeholder presense

					validate_attribute_parent(entry) # validating parent attribute

					validate_attribute_onchange(entry) #validatting onchange attribute

					validate_attribute_source(entry)
				end

				def validate_chosen_select(entry)

					validate_attribute_text_value_property(entry) #validateting text_value_property attribute

					validate_attribute_placeholder(entry) #validating placeholder presense

					validate_attribute_parent(entry) # validating parent attribute

					validate_attribute_onchange(entry) #validatting onchange attribute

				end


##################################### FORM PROPERTY ATTRIBUTE VALIDATIONS #####################

				def validate_attribute_name(entry)
					unless entry.respond_to?(self.name)
						raise "Model Class: #{entry.class}\r\nForm Property '#{self.name}'\r\nPROPERTY not found for this class"
					end
				end

				def validate_attribute_onchange(entry)
					if self.on_change

					end
				end

				def validate_attribute_parent(entry)
					if self.parent
						begin
							entry.respond_to?(self.parent)
						rescue
							raise "Current Model Class: #{entry.class}\r\nForm Property '#{self.name}'\r\nPARENT property '#{self.parent}' not found for this class"
						end
					end
				end

				def validate_attribute_class(entry)
					if self.css_class
						unless self.css_class.is_a?(String)
							raise "Current Model Class: #{entry.class}\r\nForm Property '#{self.name}'\r\nCLASS attribute is not a String'"
						end
					end
				end

				def validate_attribute_span(entry)
					if self.css_span
						unless self.css_span.is_a?(String)
							raise "Current Model Class: #{entry.class}\r\nForm Property '#{self.name}'\r\nSPAN attribute is not a String'"
						end
					end
				end

				def validate_attribute_placeholder(entry)
					if self.placeholder.nil? || self.placeholder.blank?
						raise "Current Model Class: #{entry.class}\r\nForm Property '#{self.name}'\r\nPLACEHOLDER missed"
					end
				end

				def validate_attribute_text_value_property(entry)
					unless self.text_value_property
						raise "Current Model Class: #{entry.class}\r\nForm Property '#{self.name}'\r\nTEXT_VALUE_PROPERTY attribute missed"
					end

					#if entry.respond_to?(self.text_value_property) == false
					#	raise "#{entry.class} - #{self.text_value_property} -  #{entry.respond_to?(self.text_value_property)}"
					#	raise "Current Model Class: #{entry.class}\r\nForm Property '#{self.name}'\r\nTEXT_VALUE_PROPERTY '#{self.text_value_property}' method not found for this class"
					#end
				end

				def validate_attribute_source_url(entry)
					unless self.source_url
						raise "Current Model Class: #{entry.class}\r\nForm Property '#{self.name}'\r\nSOURCE_URL attribute missed"
					end
				end

				def validate_attribute_source(entry)
					unless self.source
						raise "Current Model Class: #{entry.class}\r\nForm Property '#{self.name}'\r\nSOURCE attribute missed"
					end
				end
			end
		end
	end
end

