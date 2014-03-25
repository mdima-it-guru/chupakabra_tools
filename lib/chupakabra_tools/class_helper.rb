# -*- encoding : utf-8 -*-

module ChupakabraTools::ClassHelper
	def self.class_to_i18n(class_name)
		unless (class_name && class_name.is_a?(String) || class_name.class.to_s.downcase == "class")
			raise class_name if class_name
			raise "class_name is null"
		end
		class_name.to_s.underscore.gsub('/', '.')
	end

	def self.controller_class_to_i18n(controller_class)
		unless controller_class
			raise "supplied controller is null"
		end

		i18n_string = ::ChupakabraTools::ClassHelper.class_to_i18n(controller_class)
		i18n_string.gsub!("_controller", "") if i18n_string
		i18n_string
	end

	def self.controller_underscore(controller)
		if controller && controller.respond_to?(:controller_name)
			underscore_string = controller.controller_name.to_s.underscore
			underscore_string.gsub!("_controller", "")
			underscore_string
		end
	end

	def self.controller_full_path_underscore(controller)
		if controller
			underscore_string = controller.to_s.underscore
			underscore_string.gsub!("_controller", "")
			"/#{controller.to_s.underscore.gsub!("_controller", "")}"
		end
	end

	def self.has_action(klass, action)
		klass && action && klass.respond_to?(action)
	end

	def self.has_action?(klass, action)
		klass && action && klass.respond_to?(action)
	end

	def self.entry_has_db_attribute(entry, attribute)
		if entry && attribute

		end
		false
	end


	def self.class_is_subclass_of(parent, child)
		if parent.nil? || child.nil?
			return false
		end
		child < parent
	end

	def self.class_belongs_to_module(modul, klass)
		parent_module = klass.parent
		while (true)
			if parent_module == modul
				return true
			end
			parent_module = parent_module.parent
			break if parent_module == Object
		end
		false
	end


	def self.load_all_active_record_models
		librbfiles = File.join("#{Rails.root}/app/models/", "**", "*.rb")
		results = []

		Dir.glob(librbfiles).each do |file|
			begin
				klass_string = file.gsub("#{Rails.root}/app/models/", "")[0..-4].camelize
				klass = eval(klass_string)
				instance = klass.new

				results.push klass if instance.is_a?(ActiveRecord::Base)
			rescue => ex

			end
		end
		results
	end

	def self.property_required?(model, property)
		if model && property
			validators = model.class.validators_on(property)
			validators.each do |v|
				if v.is_a?(ActiveModel::Validations::PresenceValidator)
					return true
				end
			end
		end
		false
	end


	def self.get_controller_hierarchy(controller)
		classes_2_inspect = []
		classes_2_inspect.push(controller)
		sc = controller
		while true do
			break if sc.nil?
			sc = sc.superclass
			classes_2_inspect.push(sc)
			if sc == ApplicationController
				break
			end
		end
		classes_2_inspect
	end


	def self.get_class_hierarchy(klass)
		classes_2_inspect = []
		classes_2_inspect.push(klass)
		sc = klass
		while true do
			sc = sc.superclass
			classes_2_inspect.push(sc)
			if sc == Object || sc.nil?
				break
			end
		end
		classes_2_inspect
	end





	def self.test_engine_classes
		results = []


		Dir.glob(File.join("#{Rails.root}/app/models/", "**", "*.rb")).each do |file|
			begin
				klass_string = file.gsub("#{Rails.root}/app/models/", "")[0..-4].camelize
				klass = eval(klass_string)
				instance = klass.new if klass < ActiveRecord::Base && !klass.abstract_class == true
					#
					#results.push klass if instance.is_a?(ActiveRecord::Base)
			rescue Exception => e
				results << "**************************************************************"
				results << "ERROR: #{e}"
				results << "FILE: #{file}"
				results << e.to_s
				results << "**************************************************************"
			end
		end

		Dir.glob(File.join("#{Rails.root}/app/helpers/", "**", "*.rb")).each do |file|
			begin
				klass_string = file.gsub("#{Rails.root}/app/helpers/", "")[0..-4].camelize
				klass = eval(klass_string)
				instance = klass.new if klass < ActiveRecord::Base && !klass.abstract_class == true
					#
					#results.push klass if instance.is_a?(ActiveRecord::Base)
			rescue Exception => e
				results << "**************************************************************"
				results << "ERROR: #{e}"
				results << "FILE: #{file}"
				results << e.to_s
				results << "**************************************************************"
			end
		end


		Dir.glob(File.join("#{Rails.root}/app/controllers/", "**", "*.rb")).each do |file|
			begin
				klass_string = file.gsub("#{Rails.root}/app/controllers/", "")[0..-4].camelize
				klass = eval(klass_string)
				instance = klass.new if klass < ActiveRecord::Base && !klass.abstract_class == true
					#
					#results.push klass if instance.is_a?(ActiveRecord::Base)
			rescue Exception => e
				results << "**************************************************************"
				results << "ERROR: #{e}"
				results << "FILE: #{file}"
				results << e.to_s
				results << "**************************************************************"
			end
		end


		Rails.logger.info(results)
		results.join("\r\n")
	end


	def self.test_gem_classes_for_errors
		results = []
		Dir.glob(File.join("#{Rails.root}/lib/", "**", "*.rb")).each do |file|
			begin
				klass_string = file.gsub("#{Rails.root}/app/models/", "")[0..-4].camelize
				klass = eval(klass_string)
				instance = klass.new if klass < ActiveRecord::Base && !klass.abstract_class == true
					#
					#results.push klass if instance.is_a?(ActiveRecord::Base)
			rescue Exception => e
				results << "**************************************************************"
				results << "ERROR: #{e}"
				results << "FILE: #{file}"
				results << e.to_s
				results << "**************************************************************"
			end
		end
		Rails.logger.info(results)
		results
	end

	def self.grep(data, template)
		grep_values = []

		if data.is_a?(Array)
			data.each do |dt|
				value = dt.to_s
				if value.index(template)
					grep_values.push(value)
				end
			end
		end
		grep_values
	end

end