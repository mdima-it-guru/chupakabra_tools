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
end