#encoding: utf-8
module ChupakabraTools::Validations
	def self.russian_letters_template
		/^[а-яА-Я\ ]+$/
	end

	def russian_letters_and_digits
		/^[а-яА-Я0-9\ ,;.\-]+$/
	end


	def phone(phone, params={})

		params ||= {}


		if phone.nil?
			return params[:allow_nil] && params[:allow_nil] == true
		end

		unless phone.is_a?(String)
			phone = phone.to_s
		end

		phone.strip!

		if phone.blank?
			return params[:allow_blank] && params[:allow_blank] == true
		end

		phone = phone.gsub(/[^0-9]/, "")

		# checking phone lengths for each country
		if phone.starts_with?("7")
			# for Russia, Kazahstan, Abhazia and so on
			phone = phone.length == 11 ? phone : nil
			#phone += " Russia" if phone
		elsif phone.starts_with?("38")
			# Ukrine
			phone = phone.length == 12 ? phone : nil
			#phone += " Ukraine" if phone
		elsif phone.starts_with?("375")
			# Belarus
			phone = phone.length == 12 ? phone : nil
			#phone += " Belarus" if phone
		elsif phone.starts_with?("370")
			# Litua
			phone = phone.length == 11 ? phone : nil
			#phone += " Litva" if phone
		elsif phone.starts_with?("371")
			# Latvia
			phone = phone.length == 11 ? phone : nil
			#phone += " Latvia"  if phone
		elsif phone.starts_with?("372")
			# Estonia
			phone = phone.length == 11 || phone.length == 10 ? phone : nil
			#phone += " Estonia" if phone
		elsif phone.starts_with?("995") && phone.length != 12
			# Geogia
			phone = phone.length == 11 ? phone : nil
			#phone += " Georgia" if phone
		elsif phone.starts_with?("374")
			#Armenia
			phone = phone.length == 11 ? phone : nil
			#phone += " Armenia" if phone
		elsif phone.starts_with?("994")
			# Azerbadzhan
			phone = phone.length == 12 ? phone : nil
			#phone += " Azerbaidzhan" if phone
		elsif phone.starts_with?("373")
			# Moldova
			phone = phone.length == 11 ? phone : nil
			#phone += " Moldova" if phone
		else
			phone = nil
		end

		phone ? true : false
	end
end