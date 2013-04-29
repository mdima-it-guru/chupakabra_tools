module ChupakabraTools::Convert
	def self.string_to_value(data, data_type)
		result_value = nil

		if data
			data = data.to_s unless data.is_a?(String)
			data_type = "string" if data_type.nil?
			data_type = data_type.to_s unless data_type.is_a?(String)
			data_type.downcase!


			begin
				if data_type == "integer"
					result_value = data.to_i
				elsif data_type == "float" || data_type == "decimal"
					result_value = data.to_f
				elsif data_type == "datetime"
					result_value = data.to_datetime
				elsif data_type == "date"
					result_value = data.to_date
				elsif data_type == "time"
					result_value = data.to_time
				elsif data_type == "string"
					result_value = data
				elsif data_type == "text"
					result_value = data
				elsif data_type == "boolean"
					result_value = data == "true" || data == "1" ? true : false
				else
					result_value = nil
				end
			rescue
				#ignored
			end
		end
		result_value
	end

	def self.value_to_string(data, data_type)
		result_value = nil
		data_type.strip! if data_type && data.is_a?(String)
		begin
			if data_type == "integer"
				result_value = data
			elsif data_type == "float" ||  data_type == "decimal"
				result_value = data
			elsif data_type == "datetime"
				result_value = data
			elsif data_type == "date"
				result_value = data
			elsif data_type == "time"
				result_value = data
			elsif data_type == "string"
				result_value = data
			elsif data_type == "text"
				result_value = data
			elsif data_type == "boolean"
				result_value = data == "1" || data == "true" || data == "on" ? "true" : "false"
			else
				result_value = data
			end
		rescue
			#ignored
		end
		result_value
	end
end