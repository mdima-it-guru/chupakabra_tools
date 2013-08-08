# -*- encoding : utf-8 -*-

module ChupakabraTools::Extensions::Helpers::Models::BasicManagementUrls

	def portal_edit_url
		allow_edit = true

		if self.class.respond_to?(:action_allowed?)
			allow_edit = self.class.action_allowed?(:edit)
		end

		if allow_edit
			url_options = self.get_parent_ids if self.respond_to?(:get_parents)
			url_options = {} unless url_options && url_options.is_a?(Hash)
			url_options[:controller] = ::ChupakabaraTools::ClassHelper.controller_full_path_underscore(self.class.management_controller)
			url_options[:action] = "edit"
			url_options[:id] = self.id
			url_options[:only_path] = true

			Rails.application.routes.url_helpers.url_for(url_options)
		end
	end

	def portal_update_url
		allow_edit = true

		if self.class.respond_to?(:action_allowed?)
			allow_edit = self.class.action_allowed?(:edit)
		end

		if allow_edit
			url_options = self.get_parent_ids if self.respond_to?(:get_parents)
			url_options = {} unless url_options && url_options.is_a?(Hash)
			url_options[:controller] = ::ChupakabaraTools::ClassHelper.controller_full_path_underscore(self.class.management_controller)
			url_options[:action] = "update"
			url_options[:id] = self.id
			url_options[:only_path] = true

			Rails.application.routes.url_helpers.url_for(url_options)
		end
	end

	def portal_show_url

		allow_show = true

		if self.class.respond_to?(:action_allowed?)
			allow_show = self.class.action_allowed?(:show)
		end

		if allow_show
			url_options = self.get_parent_ids if self.respond_to?(:get_parents)
			url_options = {} unless url_options && url_options.is_a?(Hash)
			url_options[:controller] = ::ChupakabaraTools::ClassHelper.controller_full_path_underscore(self.class.management_controller)
			url_options[:action] = "show"
			url_options[:id] = self.id
			url_options[:only_path] = true

			Rails.application.routes.url_helpers.url_for(url_options)
		end
	end

	def portal_delete_url
		allow_delete = true

		if self.class.respond_to?(:action_allowed?)
			allow_delete = self.class.action_allowed?(:delete)
		end

		if allow_delete
			url_options = self.get_parent_ids if self.respond_to?(:get_parents)
			url_options = {} unless url_options && url_options.is_a?(Hash)
			url_options[:controller] = ::ChupakabaraTools::ClassHelper.controller_full_path_underscore(self.class.management_controller)
			url_options[:action] = "destroy"
			url_options[:id] = self.id
			url_options[:only_path] = true

			Rails.application.routes.url_helpers.url_for(url_options)
		end
	end

	def portal_purge_url
		allow_delete = true

		if self.class.respond_to?(:action_allowed?)
			allow_delete = self.class.action_allowed?(:purge)
		end

		if allow_delete
			url_options = self.get_parent_ids if self.respond_to?(:get_parents)
			url_options = {} unless url_options && url_options.is_a?(Hash)
			url_options[:controller] = ::ChupakabaraTools::ClassHelper.controller_full_path_underscore(self.class.management_controller)
			url_options[:action] = "purge"
			url_options[:id] = self.id
			url_options[:only_path] = true

			Rails.application.routes.url_helpers.url_for(url_options)
		end
	end
end
