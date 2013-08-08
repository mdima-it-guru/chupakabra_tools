# -*- encoding : utf-8 -*-

require 'chupakabra_tools/extensions/models/form_property'

module ChupakabraTools
	module Extensions
		module Helpers
			module Models
				module FormProperties


					################################### METHODS FOR DECLARATION IN CLASS ######################

					def form_property(name, options = {})

						property = ::ChupakabraTools::Extensions::Models::FormProperty.new(name, self, options)

						form_properties_set.push(property)
					end


					def form_properties_set
						if defined?(@form_properties_set) == false || @form_properties_set.nil? || !@form_properties_set.is_a?(Array)
							@form_properties_set = []
						end
						@form_properties_set
					end

					def filter_params_for_form_properties(params, action)
						filtered_params = {}
						if params && params.is_a?(Hash)
							form_properties_set.select do |frm_prpt|
								case frm_prpt[:mass_assignment]
									when :new

									when :update
									else
										filtered_params.push(frm_prpt)
								end
							end
						end
						filtered_params
					end

					################################### METHODS USED IN RUNTIME FLOW ######################


					def form_properties_set_for_new_form
						return_properties = []
						form_properties_set.each do |prop|
							if prop.only
								if prop.only.is_a?(Array)
									return_properties.push(prop) if prop.only.include?(:new)
								else
									return_properties.push(prop) if prop.only == :new
								end
							else
								return_properties.push(prop)
							end
						end
						return_properties
					end

					def index_property(name, options={})
						opts = {}.merge(options)

						opts[:name] = name
						index_properties_set.push(opts)
					end


					def form_properties_set_for_edit_form
						return_properties = []
						form_properties_set.each do |prop|
							if prop.only
								if prop.only.is_a?(Array)
									return_properties.push(prop) if prop.only.include?(:edit)
								else
									return_properties.push(prop) if prop.only == :edit
								end
							else
								return_properties.push(prop)
							end
						end
						return_properties
					end

					def form_properties_set_for_show_page
						return_properties = []
						form_properties_set.each do |prop|
							if prop.only
								if prop.only.is_a?(Array)
									return_properties.push(prop) if prop.only.include?(:show)
								else
									return_properties.push(prop) if prop.only == :show
								end
							else
								return_properties.push(prop)
							end
						end
						return_properties
					end

					def index_properties_set
						if defined?(@index_properties_set) == false || @index_properties_set.nil? || !@index_properties_set.is_a?(Array)
							@index_properties_set = []
						end
						@index_properties_set
					end

				end

			end
		end
	end
end

