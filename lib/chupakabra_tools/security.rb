module ChupakabraTools::Security
	def self.generate_secret(options={})
		options ||= {}

		chars = ""

		if options[:small] && options[:small] == true
			chars += ("a".."z").to_a.join
		end

		if options[:big] && options[:big] == true
			chars += ("A".."Z").to_a.join
		end

		if options[:digits] && options[:digits] == true
			chars += ("0".."9").to_a.join
		end

		if options[:specials] && options[:specials] == true
			chars += "!@#$\%^&*()_+<>/?"
		end

		if chars.blank?
			chars = ("a".."z").to_a.join
		end


		len = 8
		begin
			if options[:length] && options[:length].to_i > 5
				len = options[:length].to_i
			end
		rescue
		end

		new_pass = ""
		1.upto(len) { |i| new_pass << chars[rand(chars.size-1)] }
		new_pass
	end

	def self.get_password_hash(password)
		::Digest::SHA256.hexdigest(password)
	end
end