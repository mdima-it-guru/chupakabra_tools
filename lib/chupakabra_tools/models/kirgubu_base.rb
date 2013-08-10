# -*- encoding : utf-8 -*-

require 'digest'
require 'active_record'

class ChupakabraTools::Models::KirguduBase < ActiveRecord::Base
	self.abstract_class = true

	################################### FILTERS ######################################


	################################# INCLUSIONS #####################################


	#include SharedZone::Extensions::ModelSorting
	#extend SharedZone::Extensions::ModelSorting::ClassMethods

	include ::ChupakabraTools::Extensions::Helpers::Models::Sorting
	extend ::ChupakabraTools::Extensions::Helpers::Models::Sorting::ClassMethods

	extend ::ChupakabraTools::Extensions::Helpers::Models::FormProperties
	extend ::ChupakabraTools::Extensions::Helpers::Models::Filters
	extend ::ChupakabraTools::Extensions::Helpers::Models::UncloneableProperties


	unclonable_property :id, :updated_at, :created_at


	################################# INSTANCE METHODS ######################################

	def deletion_status_name
		::SharedZone::DeletionStatus[deletion_status_id] if self.respond_to?(:deletion_status_id)
	end

	def is_active_label
		I18n.t(is_active ? 1 : 0, scope: "shared_zone.labels.yes_no") if self.respond_to?(:is_active)
	end

	def is_html_label
		I18n.t(is_html ? 1 : 0, scope: "shared_zone.labels.yes_no") if self.respond_to?(:is_html)
	end

	def name_for_breadcrumbs
		name
	end

	def to_s
		name
	end

	def clone
		self.class.new(self.attributes.except(self.class.unclonable_properties_set))
	end

	def to_i18n
		self.class.to_i18n
	end

	def self.to_i18n
		::ChupakabraTools::ClassHelper.class_to_i18n(self)
	end

	def self.generate_hash(data)
		data = "" unless data
		Digest::SHA1.hexdigest(data)
	end

	def generate_hash(data)
		self.class.generate(hash)
	end



	def self.belongs_to_module?(modul)
		::ChupakabraTools::ClassHelper.class_belong_to_module(modul, self)
	end
	def belongs_to_module?(modul)
		self.class.belongs_to_module?(modul)
	end


	def self.is_subclass?(parent_class)
		::ChupakabraTools::ClassHelper.class_is_subclass_of(parent_class, self)

	end
	def is_subclass?(parent_class)
		self.class.is_subclass?(parent_class)
	end

	################################# METHODS MOVED FROM DataRetriever ######################################

	def self.get_entries(controller, query, filters, options)
		options ||= {}
		options.symbolize_keys!

		logger = options[:logger]

		filters ||= {}
		filters.stringify_keys!

		logger.debug("Incoming Filters: #{filters.to_json}") if logger

		unless options[:skip_filters] == true
			if self.respond_to?(:data_filters_set)
				logger.debug("Data Filters: #{self.data_filters_set}") if logger
				self.data_filters_set.each do |df|
					filter_value = options[df.name.to_s]
					if filter_value && !filter_value.blank?
						filter_name = df.filter_name.to_s
						if filter_name.nil? || filter_name.to_s.blank?
							filter_name = df.name
						end
						filters[filter_name] = filter_value
					end
				end
			end
		end

		logger.debug("Sanitized filters: #{filters.to_json}") if logger

		controller.fill_obligatory_filters(filters, options)

		logger.debug("Applied filters: #{filters.to_json}") if logger

		filters[:per_page] = options['per_page'] if options['per_page']
		filters[:page] = options['page'] if options['page']

		#raise filters.to_json
		filters.symbolize_keys!

		if query && !query.is_a?(::ActiveRecord::Relation)
			raise "Query must be nil or ActiveRecord::Relation"
		end

		unless query
			query = self
		end

		self.apply_filters_to_query(query, filters)
	end


	def self.get_entry_name(controller, id, options={})
		options ||= {}
		logger = options[:logger]
		found_text_value = nil
		entry = get_entry_by_id(controller, id, options)
		found_text_value = entry.to_s if entry
		found_text_value
	end

	def self.get_entry_by_id(controller, id, filters, options={})
		options ||= {}
		logger = options[:logger]
		self.get_entries(controller, nil, filters, options).where(id: id).first
	end


	def self.get_entries_for_select(controller, source, filters, options)
		options ||= {}
		filters ||= {}
		logger = options[:logger]
		options[:logger] = nil
		select_data = nil

		logger.info("=======================::SharedZone::DataRetriever.GetEntriesForSelect=======================") if logger
		logger.info("CONTROLLER: #{controller.class}") if logger

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

			if source < ActiveRecord::Base || source.is_a?(ActiveRecord::Relation)
				id_property = :id unless id_property
				name_property = :name unless name_property

				logger.info("Process: SOURCE RESPOND TO :apply_filters_to_query") if logger

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

				select_data = self.get_entries(controller, source, filters, options).map { |u| [u.send(name_property), u.send(id_property)] }
			elsif source.is_a?(String)
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
			else
				logger.info("Process: UNEXPECTED TYPE OF SOURCE #{source.class}") if logger
			end
		else
			logger.error("Process: SOURCE NOT SUPPLIED") if logger
		end

		logger.info("======================= END of::SharedZone::DataRetriever.GetEntriesForSelect=======================") if logger
		select_data
	end

	def self.apply_filters_to_query(query, filters = {})
		filters ||= {}
		per_page = filters[:per_page] || WillPaginate.per_page
		per_page = 99999 if per_page.nil? || per_page <= 0
		order_by = filters[:order] || 'name asc'
		page = nil
		page = filters[:page].to_i if filters[:page]
		if page && page < 1
			page = 1
		end

		query = query.by_deletion_status(filters[:deletion_status_id]) if self.respond_to?(:by_deletion_status)

		query
		.order(order_by)
		.page(page)
		.per_page(per_page)
	end


end
