# -*- encoding : utf-8 -*-

module ChupakabraTools
	module Extensions
		module Helpers
			module Controllers
				module BasicActions

					def index
						raise "No defined \"entry_class\" method for controller #{self.class}" if !self.respond_to?(:entry_class) || self.entry_class.nil?
						raise "Current User NULL" if @current_user.nil?

						filters = {}.merge(params)
						options = {}
						options[:logger] = string_logger

						#logger.info "OPTIONS FOR SEARCH: #{options.to_s}"

						@entries_list = self.entry_class.get_entries(self, nil, filters, options)

						load_data_from_datasources_for_filters

						respond_to do |format|
							format.html { render_html1 get_index_view_path }
							format.json { render_json_nav(@entries_list) }
						end
					end

					def show
						@entry = self.entry_class.get_entry_by_id(self, params[:id], nil, {logger: string_logger})

						unless @entry
							respond_to do |format|
								flash[:error] = I18n.t("#{::ChupakabraTools::ClassHelper.controller_to_i18n(self)}.messages.not_found", id: params[:id])
								format.html { render_html1 get_not_found_view_path, locals: {entry: @entry} }
								format.json { render json: @entry.errors, status: :unprocessable_entity }
							end
							return
						end

						# loading data for select-like controls
						load_data_from_datasources_for_form(:show, @entry)

						respond_to do |format|
							format.html { render_html1 get_show_view_path, locals: {entry: @entry} }
							format.json { render json: @entry }
						end
					end

					def new
						@entry = entry_class.new
						load_data_from_datasources_for_form(:new, @entry)

						respond_to do |format|
							format.html { render_html1 get_new_view_path, locals: {entry: @entry} }
							format.json { render json: @entry }
						end
					end


					def edit
						@entry = self.entry_class.get_entry_by_id(self, params[:id], nil, {logger: string_logger})

						unless @entry
							respond_to do |format|
								flash[:error] = I18n.t("#{::ChupakabraTools::ClassHelper.controller_to_i18n(self)}.messages.not_found", id: params[:id])
								format.html { render_html1 get_not_found_view_path, locals: {entry: @entry} }
								format.json { render json: @entry.errors, status: :unprocessable_entity }
							end
							return
						end
						# loading data for select-like controls
						load_data_from_datasources_for_form(:edit, @entry)

						respond_to do |format|
							format.html { render_html1 get_edit_view_path, locals: {entry: @entry} }
							format.json { render json: @entry }
						end
					end

					def create
						@entry = self.entry_class.new(params[:"#{self.entry_class.to_s.underscore.gsub('/', '_')}"])

						transaction_is_ok = true

						filter_params = {}.merge(params)

						process_transaction_out_filters(@entry, :before_create, filter_params, {logger: self.string_logger})

						ActiveRecord::Base.transaction do
							#raise "In Transaction Before Create"
							transaction_is_ok |= process_transaction_in_filters(@entry, :before_create, filter_params, {logger: self.string_logger})
							if transaction_is_ok
								if @entry.save
									transaction_is_ok |= process_transaction_in_filters(@entry, :after_create, filter_params, {logger: self.string_logger})
								else
									transaction_is_ok = false
								end
							end
							if transaction_is_ok == false
								raise ActiveRecord::Rollback
							end
						end

						process_transaction_out_filters(@entry, :after_create, filter_params, {logger: self.string_logger})

						respond_to do |format|
							if transaction_is_ok == true
								flash[:success] = I18n.t("#{::ChupakabraTools::ClassHelper.controller_to_i18n(self)}.messages.entry_created", entry_name: @entry.to_s)
								format.html { render_redirect url_for(action: 'show', id: @entry) }
								format.json { render json: @entry, status: :created, location: @entry }
							else
								# loading data for select-like controls
								load_data_from_datasources_for_form(:new, @entry)
								flash[:error] = I18n.t("#{::ChupakabraTools::ClassHelper.controller_to_i18n(self)}.messages.create_error")
								format.html { render_html1 get_new_view_path, locals: {entry: @entry} }
								format.json { render json: @entry.errors, status: :unprocessable_entity }
							end
						end
					end

					def update
						@entry = self.entry_class.get_entry_by_id(self, params[:id], nil, {logger: string_logger})

						# Render NOT FOUND Form
						unless @entry
							respond_to do |format|
								flash[:error] = I18n.t("#{::ChupakabraTools::ClassHelper.controller_to_i18n(self)}.messages.not_found", id: params[:id])
								format.html { render_html1 get_not_found_view_path, locals: {entry: @entry} }
								format.json { render json: @entry.errors, status: :unprocessable_entity }
							end
							return
						end

						respond_to do |format|
							flash[:success] = I18n.t("#{::ChupakabraTools::ClassHelper.controller_to_i18n(self)}.messages.manufacturer_updated", entry_name: @entry.to_s)
							if @entry.update_attributes(params[:"#{entry_class.to_s.underscore.gsub('/', '_')}"])
								format.html { render_redirect url_for(action: 'show', id: @entry) }
								format.json { head :no_content }
							else
								# loading data for select-like controls
								load_data_from_datasources_for_form(:edit, @entry)
								flash[:error] = I18n.t("#{::ChupakabraTools::ClassHelper.controller_to_i18n(self)}.messages.update_error")
								format.html { render_html1 get_edit_view_path, locals: {entry: @entry} }
								format.json { render json: @entry.errors, status: :unprocessable_entity }
							end
						end
					end


					def edit_inplace
						item = self.entry_class.get_entry_by_id(self, params[:id], nil, {logger: string_logger})
						if item
							result_string = ''
							begin
								unless item[params[:field_name]] == params[:value]
									item[params[:field_name]] = params[:value]
									item.updated_at = Time.now
									item.updater = @current_user
									unless item.save
										result_string = '<span style = "color: red;"><b>FAILED TO SAVE!!!</b></span>'
									end
								end
							rescue
								result_string = '<span style = "color: red;"><b>ERROR OCCURED!!!</b></span>'
							end
							if result_string.blank?
								if params[:field_name] == 'priority'
									result_string = item.priority
								elsif params[:field_name] == 'status_id'
									result_string = item.status
								elsif  params[:field_name] == 'name'
									result_string = item.name
								end
							end

							render text: result_string
						else
							render text: '<span style = "color: red;"><b>NOT FOUND!!!</b></span>'
						end
					end


					def export
						raise "No defined \"entry_class\" method for controller #{self.class}" if !self.respond_to?(:entry_class) || self.entry_class.nil?
						raise "Current User NULL" if @current_user.nil?

						filters = {}.merge(params)
						options = {}
						options[:logger] = string_logger

						#logger.info "OPTIONS FOR SEARCH: #{options.to_s}"

						@entries_list = self.entry_class.get_entries(self, nil, filters, options)

						export_type = params[:type]

						unless export_type

						end

						export_options = {}

						self.entry_class.export_types_set.each do |exp|
							if exp[:name] == export_type
								#export_options[:include] =
								#render text: @entries_list.to_json
							end
						end

						if params[:type]
							case params[:type]
								when "json"

								when "xml"
									render text: @entries_list.to_xml
							end
						else
							respond_to do |format|
								format.json { render json: @entries_list }
								format.json { render xml: @entries_list }
							end
						end
					end

					def import
						import_type = params[:type]

					end


#************************************************************************************************************
#************************************************************************************************************
#************************************************* PRIVATE METHODS ******************************************
#************************************************************************************************************
#************************************************************************************************************

					private

					def get_index_view_path
						view_path = "/shared/entry_index_renderer"

						if self.respond_to?(:index_view_path)
							view_path = self.index_view_path
						end
						view_path
					end


					def get_edit_view_path
						view_path = "/shared/entry_edit_form_renderer"

						if self.respond_to?(:edit_view_path)
							view_path = self.edit_view_path
						end
						view_path
					end

					def get_new_view_path
						view_path = "/shared/entry_new_form_renderer"

						if self.respond_to?(:new_view_path)
							view_path = self.new_view_path
						end
						view_path
					end

					def get_show_view_path
						view_path = "/shared/entry_show_renderer"

						if self.respond_to?(:show_view_path)
							view_path = self.show_view_path
						end
						view_path
					end

					def get_not_found_view_path
						view_path = "/shared/entry_not_found_renderer"

						if self.respond_to?(:show_view_path)
							view_path = self.show_view_path
						end
						view_path
					end


					#*********************************    DATA FOR SELECTS    ***********************************

					def load_data_from_datasources_for_form(aktion, entry)
						@entry_data_sources = {}

						class_properties_for_form = []

						#string_logger.info("*********************** LOADING DATA FOR SELECTS *****************************")

						if aktion == :new || aktion == :create
							class_properties_for_form = self.entry_class.form_properties_set_for_new_form
						elsif aktion == :edit || aktion == :update
							class_properties_for_form = self.entry_class.form_properties_set_for_edit_form
						end

						class_properties_for_form.each do |property|
							if property.input_type == :chosen_select || property.input_type == :select
								#string_logger.info("ChosenSelect for Property : #{property[:name]}")
								@entry_data_sources[property.name] = load_data_for_select(property, entry)
							end
						end

						#string_logger.info("ENTRY DATA SOURCES: #{@entry_data_sources.to_json}")
						#string_logger.info("************************************************************************")
					end

					def load_data_from_datasources_for_filters
						@data_sources_for_filters = {}

						class_properties_for_form = []

						#string_logger.info("*********************** LOADING DATA FOR SELECTS *****************************")
						if self.entry_class.respond_to?(:data_filters_set)
							self.entry_class.data_filters_set.each do |filter|
								if filter.input_type == :chosen_select || filter.input_type == :select
									#string_logger.info("ChosenSelect for Property : #{property[:name]}")
									@data_sources_for_filters[filter.name] = load_data_for_select(filter, nil)
								end
							end
						end
					end


					def load_data_for_select(property, entry)
						#if property.predefined_values
						#	return property.predefined_values
						#end


						parent_value = nil
						parent_value = entry[property.parent] if entry


						get_entries_for_select(property.source, parent_value: parent_value, logger: string_logger)
					end

					def get_entries_for_select(source, options={})

						options ||= {}
						logger = options[:logger]
						options[:logger] = nil
						select_data = nil

						if source
							id_property = nil
							name_property = nil

							logger.info("Process: SOURCE SUPPLIED") if logger
							if source.is_a?(Hash)
								logger.info("Process: SOURCE IS HASH") if logger
								id_property = source[:id] || :id
								name_property = source[:name] || :name
								source = source[:klass]
							end

							if source.is_a?(String)
								source_data = I18n.t(source)

								select_data = []

								source_data.keys.each do |key|
									select_data.push([source_data[key].to_s, key.to_s.to_i])
								end
							elsif source.is_a?(Array)
								select_data = []
								source.each do |e|
									if e.is_a?(Array)
										select_data.push(e)
									elsif e.is_a?(Hash)
										select_data.push([e[:name], e[:id]])
									else
										select_data.push([e.to_s, e])
									end
								end
							elsif source.is_a?(Range)
								select_data = []
								#raise source.to_json
								source.each do |e|
									select_data.push([e.to_s, e])
								end
							elsif source < ::ChupakabraTools::ActiveEnumExtended
								select_data = source.to_select
								logger.info("Selected #{select_data.count} entries") if logger
							elsif source < ActiveRecord::Base || source < ActiveRecord::Relation
								id_property = :id unless id_property
								name_property = :name unless name_property

								logger.info("Process: SOURCE RESPOND TO :apply_filters_to_query") if logger
								filters = {}.merge(options)

								filters[:parent] = nil
								filters[:parent_value] = nil

								if options[:parent]
									logger.info("Process: PARENT PROPERTY DEFINED #{options[:parent]}") if logger
									if options[:parent_value]
										logger.info("Process: PARENT VALUE DEFINED #{options[:parent_value]}") if logger
										filters[options[:parent]] = options[:parent_value]
									else
										logger.info("Process: PARENT PROPERTY DEFINED #{options[:parent]}, BUT NOT VALUE SUPPLIED") if logger
										return []
									end
								end
								filters[:per_page] = 9999999
								filters[:page] = 1

								select_data = source.get_entries(self, nil, filters, options).select([name_property, id_property]).map { |u| [u.send(name_property), u.send(id_property)] }
							else
								logger.info("Process: UNEXPECTED TYPE OF SOURCE #{source.class}") if logger
							end
						else
							logger.error("Process: SOURCE NOT SUPPLIED") if logger
						end
						select_data
					end

					#**********************       /DATA FOR SELECTS         ***********************

					#**********************       TRANSACTION FILTERS      ************************
					def process_filters(entry, filter_name, filter_params, available_filters, options)
						options ||= {}
						logger = options[:logger]

						transaction_is_ok = true
						logger.debug "#{filter_name} filters start", options if logger
						logger.depth_up
						available_filters.each do |filter|
							logger.debug("Execute Filter Method #{filter[:method]}")
							if self.send(filter[:method], entry, filter_params, options) == false
								transaction_is_ok |= false
							end
						end
						logger.depth_down
						logger.debug "#{filter_name} filters end", options if logger

						transaction_is_ok
					end


					def process_transaction_in_filters(entry, filter_name, filter_params, options= {})
						found_filters = []
						::ChupakabraTools::ClassHelper.get_class_hierarchy_for_class(self.class).each do |cl|
							if cl.respond_to?(:in_transaction_filters_collection)
								cl.in_transaction_filters_collection(filter_name).each do |action|
									found_filters.push(action)
								end
							end
						end
						#raise "In transaction Found filters: #{found_filters.count}"
						process_filters(entry, filter_name, filter_params, found_filters, options)
					end

					def process_transaction_out_filters(entry, filter_name, filter_params, options = {})
						found_filters = []
						::ChupakabraTools::ClassHelper.get_class_hierarchy_for_class(self.class).each do |cl|
							if cl.respond_to?(:out_transaction_filters_collection)
								cl.out_transaction_filters_collection(filter_name).each do |action|
									found_filters.push(action)
								end
							end
						end
						process_filters(entry, filter_name, filter_params, found_filters, options)
					end

					#************************    /TRANSACTION FILTERS    ************************


					def sanitize_params_for_mass_assignment(klass, prms)

						unless klass && klass < ActiveRecord::Base
							raise "Class '#{klass}' must be an ActiveRecord::Base descendant"
						end

						options = {}
						if prms || prms.is_a?(Hash)
							prms.keys.each do |key|
								if klass.accessible_attributes.contains(key)
									options[key] = prms[key]
								end
							end
						end
					end


				end
			end
		end
	end
end
