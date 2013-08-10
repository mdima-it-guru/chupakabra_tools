# -*- encoding : utf-8 -*-

module ChupakabraTools::Helpers::BreadcrumbsHelper

	def self.included(base)
		base.class_eval do
			include InstanceMethods
		end
	end

	module InstanceMethods

		def add_new_breadcrumb(name, path = nil)
			self.breadcrumbs << {label: name, url: path}
		end

		def breadcrumbs
			@breadcrumbs ||= []
		end

		def breadcrumbs_length
			self.breadcrumbs.length
		end
	end
end
