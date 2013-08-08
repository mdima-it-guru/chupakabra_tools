# -*- encoding : utf-8 -*-


module ChupakabraTools
	module Extensions
		module Helpers
			module Models
				module Scopes
					module WithName
						def self.included(base)
							base.scope :with_name, lambda {
								|value|
								if value
									value = value.gsub('%', ' ').strip
									like_value ="%#{value}%"
									base.where { (name.like like_value) }
								end
							}

						end
					end

					module WithSeoTag
						def self.included(base)
							base.scope :with_seo_tag, lambda {
								|value|
								if value
									value = value.gsub('%', ' ').strip
									like_value ="%#{value}%"
									base.where { (seo_tag.like like_value) }
								end
							}
						end
					end

					module WithTitle
						def self.included(base)
							base.scope :with_title, lambda {
								|value|
								if value
									value = value.gsub('%', ' ').strip
									like_value ="%#{value}%"
									base.where { (title.like like_value) }
								end
							}
						end
					end

					module ByDeletionStatus
						def self.included(base)
							base.scope :by_deletion_status, lambda {
								|value|
								if value
									base.where(deletion_status_id: value)
								end
							}
						end
						# "deletion_status_name" method is defined in KirguduBaseModel
					end

					module WithIsActive
						def self.included(base)
							base.scope :with_is_active, lambda {
								|value|
								if value
									base.where(is_active: value)
								end
							}
						end
						# "is_active_label" method is defined in KirguduBaseModel
					end

					module WithIsHtml
						def self.included(base)
							base.scope :with_is_html, lambda {
								|value|
								if value
									base.where(is_html: value)
								end
							}
						end
						# "is_html_label" method is defined in KirguduBaseModel
					end

					module OrderBy
						def self.included(base)
							base.scope :order_by, lambda {
								|value|
								if value
									base.order(value)
								end
							}
						end
					end

					module ByID
						def self.included(base)
							base.scope :by_id, lambda { |value| base.where(id: value) if value }
						end
					end
				end
			end
		end
	end
end

