# -*- encoding : utf-8 -*-

module ChupakabraTools
	module Extensions
		module Helpers
			module Controllers
				module ContainerItemsManagementActions


					def self.included(base)
						base.class_eval do
							include InstanceMethods
						end
					end


					module InstanceMethods
						def managing_items_index
							@container = get_managing_container_class.find(params[get_managing_parent_id_key])
							@items = get_managing_item_class.where(container_id: @container).order(:sort_position).page(params[:page_id])

							@managing_item_class = get_managing_item_class.to_s
							@managing_container_class = get_managing_container_class.to_s

							views_path = get_managing_views_path if self.respond_to?(:get_managing_views_path)
							views_path = "/shared/manage_items/" unless views_path

							respond_to do |format|
								format.html { render_html1("#{views_path}managing_items_index") }
								format.json { render json: @container }
							end
						end

						def managing_items_manage
							@container = get_managing_container_class.find(params[get_managing_parent_id_key])
							@items = get_managing_item_class.where(container_id: @container).order(:sort_position).page(params[:cpage])

							@managing_item_class = get_managing_item_class.to_s
							@managing_container_class = get_managing_container_class.to_s


							container_all_items_ids = Array.new

							get_managing_item_class.where(container_id: @container.id).map { |u| container_all_items_ids.push(u.entry_id) }


							entries_order_by = get_managing_entries_order_by if self.respond_to?(:get_managing_entries_order_by)
							entries_order_by = "name asc" unless entries_order_by

							@entries = get_managing_entry_class.where { -(id.in container_all_items_ids) }.page(params[:ppage]).order(entries_order_by)


							views_path = get_managing_views_path if self.respond_to?(:get_managing_views_path)
							views_path = "/shared/manage_items/" unless views_path

							respond_to do |format|
								format.html { render_html1("#{views_path}managing_items_manage") }
								format.json { render json: @entries }
							end
						end

						def managing_items_add
							container = get_managing_container_class.where(id: params[get_managing_parent_id_key]).first
							entry = get_managing_entry_class.where(id: params[:entry_id]).first


							unless container
								render json: {status: ::ChupakabraTools::SetManagementResult.id_by_tag('set_not_found'), message: I18n.t("#{::ChupakabraTools::ClassHelper.controller_to_i18n(self)}.management.messages.set_not_found", id: params[:id])}
								return
							end
							unless entry
								render json: {status: ::ChupakabraTools::SetManagementResult.id_by_tag('entry_not_found'), message: I18n.t("#{::ChupakabraTools::ClassHelper.controller_to_i18n(self)}.management.messages.entry_not_found", entry_id: params[:entry_id])}
								return
							end

							item = get_managing_item_class.where(container_id: container.id, entry_id: entry).first

							unless item
								item = get_managing_item_class.new
								item.container_id = container.id
								item.entry_id = entry.id
								max_sort_position = get_managing_item_class.where(container_id: container.id).maximum(:sort_position)
								item.sort_position = max_sort_position ? max_sort_position + 1 : 1

								if item.save
									render json: {status: ::ChupakabraTools::SetManagementResult.id_by_tag('management_ok'), message: I18n.t("#{::ChupakabraTools::ClassHelper.controller_to_i18n(self)}.management.messages.add_management_ok")}
								else
									render json: {status: ::ChupakabraTools::SetManagementResult.id_by_tag('management_error'), message: I18n.t("#{::ChupakabraTools::ClassHelper.controller_to_i18n(self)}.management.messages.add_management_error")}
								end
							else
								render json: {status: ::ChupakabraTools::SetManagementResult.id_by_tag('entry_already_in_set'), message: I18n.t("#{::ChupakabraTools::ClassHelper.controller_to_i18n(self)}.management.messages.entry_already_in_set")}
							end
						end

						def managing_items_remove
							container = get_managing_container_class.where(id: params[:id]).first


							unless container
								render json: {status: ::ChupakabraTools::SetManagementResult.id_by_tag('set_not_found'), message: I18n.t("#{::ChupakabraTools::ClassHelper.controller_to_i18n(self)}.management.messages.set_not_found", id: params[:id])}
								return
							end

							item = get_managing_item_class.where(container_id: container.id, entry_id: params[:entry_id]).first
							unless item
								render json: {status: ::ChupakabraTools::SetManagementResult.id_by_tag('item_not_found'), message: I18n.t("#{::ChupakabraTools::ClassHelper.controller_to_i18n(self)}.management.messages.item_not_found", entry_id: params[:entry_id])}
								return
							end

							if item.destroy
								render json: {status: ::ChupakabraTools::SetManagementResult.id_by_tag('management_ok'), message: I18n.t("#{::ChupakabraTools::ClassHelper.controller_to_i18n(self)}.management.messages.remove_management_ok")}
							else
								render json: {status: ::ChupakabraTools::SetManagementResult.id_by_tag('management_error'), message: I18n.t("#{::ChupakabraTools::ClassHelper.controller_to_i18n(self)}.management.messages.remove_management_error")}
							end
						end
					end

				end
			end
		end
	end
end
