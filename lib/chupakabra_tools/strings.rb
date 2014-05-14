module ChupakabraTools::Strings
	def self.cut_string(string, length, options={})
		options ||= {}
		options.stringify_keys!

		string ||= ""

		length ||= 30

		if string.length > length
			string[0..length] + "..."
		end
	end

	def self.trim(str, chars = nil, options = {})
		# testing "str" for valid string

		options = { force_trim_whitespaces: false }.merge!(options || {})

		return str if str.nil?
		return nil if !str.is_a?(String)
		return "" if str.blank?
		# testing "chars" for valid string
		return str.strip if chars.nil? || !chars.is_a?(String) || chars.blank? || chars.length > 1
		result_str = str

		result_str.strip! if options[:force_trim_whitespaces]
		result_str = result_str.slice(1..result_str.length-1) while result_str.length > 0 && result_str.chr == chars
		result_str.reverse!
		result_str = result_str.slice!((1..result_str.length-1)) while result_str.length > 0 && result_str.chr == chars
		result_str.reverse!





	end
end