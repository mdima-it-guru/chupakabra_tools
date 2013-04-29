module ChupakabraTools::ActiveRecord
	def self.sanitize_sortorder(sort_order = nil)
		return 'asc' if  sort_order.nil? || sort_order.empty?
		return 'asc' if sort_order.downcase == 'asc'
		return 'desc' if sort_order.downcase == 'desc'
		return 'asc'
	end

	def self.sanitize_order(sort_order = nil)
		sanitize_sortorder(sort_order)
	end

	def self.invert_sortorder(sort_order = nil)
		return 'desc' if sort_order.nil? || sort_order.empty?
		sort_order = sanitize_sortorder(sort_order)
		return 'desc' if sort_order.downcase == 'asc'
		'asc'
	end

	def self.invert_order(sort_order = nil)
		invert_sortorder(sort_order)
	end


	def self.sanitize_sort_by(sort_by, fields_to_sort, default_sort_by = nil)
		unless sort_by.nil? || sort_by.empty? || fields_to_sort.nil? || !fields_to_sort.is_a?(Array)
			fields_to_sort.each do |fts|
				if fts.downcase == sort_by
					return sort_by
				end
			end
			return default_sort_by
		end

		return default_sort_by.nil? || default_sort_by.empty? ? default_sort_by : 'id'
	end

end