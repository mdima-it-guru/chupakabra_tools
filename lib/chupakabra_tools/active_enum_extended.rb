# -*- encoding : utf-8 -*-
require "active_enum"

class ChupakabraTools::ActiveEnumExtended < ActiveEnum::Base


	def self.id_by_tag(tag)
		self.all.each do |item|
			return item[0] if item[2][:tag] == tag
		end
		nil
	end

	def self.tag_by_id(id)
		self.all.each do |item|
			return item[2][:tag] if item[0] == id
		end
		nil
	end

	def self.all_tags
		self.all.map{ |item| item[2][:tag] }
	end

	def self.all_ids
		self.all.map{ |item| item[0] }
	end

	def self.for_select
		self.all.map{ |item| [item[1], item[2][:tag]] }
	end

	def self.to_hash(data = nil)
		unless data
			return self.all.map{ |item| {id: item[0], name: item[1], tag: item[2][:tag]} }
		end
		if data.is_a?(String)
			self.all.each do |item|
				if item[2][:tag] == data
					return {id: item[0], name: item[1], tag: item[2][:tag]}
				end
			end
		end
		if data.is_a?(Integer)
			self.all.each do |item|
				if item[0] == data
					return {id: item[0], name: item[1], tag: item[2][:tag]}
				end
			end
		end
	end
end

