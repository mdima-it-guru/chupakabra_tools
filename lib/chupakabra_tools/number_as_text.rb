#encoding: utf-8
module ChupakabraTools::NumberAsText

	def self.number_to_russian_string(money)

		number_strings = Hash.new
		number_strings[:thousands] = ["тысяч", "тысяча", "тысячи", "тысячи", "тысячи", "тысяч", "тысяч", "тысяч", "тысяч", "тысяч"]
		number_strings[:millions] = ["миллионов", "миллион", "миллиона", "миллиона", "миллиона", "миллионов", "миллионов", "миллионов", "миллионов", "миллионов"]
		number_strings[:billions] = ["миллиардов", "миллиард", "миллиарда", "миллиарда", "миллиарда", "миллиардов", "миллиардов", "миллиардов", "миллиардов", "миллиардов"]
		number_strings[:trillions] = ["триллионов", "триллион", "триллиона", "триллиона", "триллиона", "триллионов", "триллионов", "триллионов", "триллионов", "триллионов"]


		money_trilions = extract_number_order(number, "trillions")
		if money_trilions > 0

		end
		money_billions = extract_number_order(number, "billions")
		if money_billions > 0

		end
		money_millions = extract_number_order(number, "millions")
		if money_millions > 0

		end
		money_thousands = extract_number_order(number, "thousands")
		if money_thousands > 0

		end

		money_hundreds = extract_number_order(number, "")

	end

	def self.format_hundreds(number)
		number_strings = Hash.new
		number_strings["1-9"] = ["", "один", "два", "три", "четыре", "пять", "шесть", "семь", "восемь", "девять"]
		number_strings["10-19"] =["десять", "одиннадцать", "двенадцать", "тринадцать", "четырнадцать", "пятнадцать", "шестнадцать", "семнадцать", "восемнадцать", "девятнадцать"]
		number_strings["20-90"] = ["", "", "двадцать", "тридцать", "сорок", "пятьдесят", "шестьдесят", "семьдесят", "восемьдесят", "девяносто"]
		number_strings["100-900"] = ["", "сто", "двести", "триста", "четыреста", "пятьсот", "шестьсот", "семьсот", "восемьсот", "девятьсот"]

		money_string = ""
		money_hundreds = ((number/ 100).to_i * 100 - (number / 1000).to_i * 1000) / 100

		if money_hundreds > 0
			money_string += number_strings["100-900"]
		end

	end

	def self.extract_number_order(number, order)
		devider = 1
		if order == "trillions"
			devider = 1000000000000
		elsif order == "billions"
			devider = 1000000000
		elsif order == "millions"
			devider = 1000000
		elsif order == "thousands"
			devider = 1000
		end
		((number/devider).to_i * devider - (number/(devider * 1000)).to_i * devider * 1000)/devider
	end

end