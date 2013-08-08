module ChupakabraTools::ActiveRecord
	def sanitize_order(sort_order = nil)
		return 'asc' if  sort_order.nil? || sort_order.empty?
		return 'asc' if sort_order.downcase == 'asc'
		return 'desc' if sort_order.downcase == 'desc'
		'asc'
	end

	def self.invert_order(sort_order = nil)
		return 'desc' if sort_order.nil? || sort_order.empty?
		sort_order = sanitize_sortorder(sort_order)
		return 'desc' if sort_order.downcase == 'asc'
		'asc'
	end

	def sanitize_sort_by(sort_by)


		unless sort_by.nil? || sort_by.empty?

			fields_to_sort.each do |fts|
				if fts.downcase == sort_by
					return sort_by
				end
			end
			return default_sort_by
		end

		default_sort_by.nil? || default_sort_by.empty? ? default_sort_by : 'id'
	end


	def self.default_sort_field
		defined?(@default_sort_field) ? @default_sort_field : nil
	end

	def self.default_sort_field= value
		if value
			@default_sort_field = value.to_s
		else
			@default_sort_field = nil
		end
	end

	def self.allowed_fields_to_sort
		unless defined?(@allowed_fields_to_sort)
			@allowed_fields_to_sort = []
		end
		@allowed_fields_to_sort
	end

	def self.allowed_fields_to_sort= value
		@allowed_fields_to_sort = []
		if value
			if value.is_a?(Array)
				value.each do |i|
					@allowed_fields_to_sort.push i.to_s
				end
			else
				@allowed_fields_to_sort.push value.to_s
			end
		end
	end
end