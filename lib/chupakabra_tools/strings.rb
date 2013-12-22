module ChupakabraTools::Strings
	def self.trim(string, length, options={})
		options ||= {}
		options.stringify_keys!

		string ||= ""

		length ||= 30

		if string.length > length
			string.trim!(length) + "..."
		end
	end
end