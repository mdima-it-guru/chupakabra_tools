# -*- encoding : utf-8 -*-

module ChupakabraTools
	module Extensions
		module Helpers
			module Controllers
				module ContainerItemsSortingActions

					def self.included(base)
						base.class_eval do
							include InstanceMethods
						end
					end

					module InstanceMethods
						def managing_items_sort_index
							@container= get_managing_container_class.find(params[get_managing_parent_id_key])
							@items = get_managing_item_class.where(container_id: @container.id).order(:sort_position)


							views_path = get_managing_views_path if self.respond_to?(:get_managing_views_path)
							unless views_path
								views_path = "/shared/manage_items/"
							end

							respond_to do |format|
								format.html { render_html1("#{views_path}managing_items_sort_index") }
								format.json { render json: @products }
							end
						end

						def managing_items_sort_process
							container = get_managing_container_class.find(params[get_managing_parent_id_key])
							unless container
								render json: {status: ::ChupakabraTools::SetManagementResult.id_by_tag('set_not_found'), message: I18n.t("#{::ChupakabraTools::ClassHelper.controller_to_i18n(self)}.sorting.messages.set_not_found", id: params[:id])}
								return
							end

							result_is_ok = false
							if params[:items]
								begin
									ActiveRecord::Base.transaction do
										params[:items].each_with_index do |id, index|
											item = get_managing_item_class.where(container_id: container.id, entry_id: id).first
											if item
												item.sort_position = index + 1
												if item.respond_to?(:updated_by)
													item.updated_by = @current_user.id
												end
												item.save
											end
										end
										result_is_ok = true
									end
								end
							end
							if result_is_ok == true
								render json: {status: ::ChupakabraTools::SetManagementResult.id_by_tag('management_ok'), message: I18n.t("#{::ChupakabraTools::ClassHelper.controller_to_i18n(self)}.sorting.messages.management_ok")}
							else
								render json: {status: ::ChupakabraTools::SetManagementResult.id_by_tag('management_error'), message: I18n.t("#{::ChupakabraTools::ClassHelper.controller_to_i18n(self)}.sorting.messages.management_error")}
							end
						end
					end
				end
			end
		end
	end
end
