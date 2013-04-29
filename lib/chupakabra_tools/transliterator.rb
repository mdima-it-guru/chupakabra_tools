require "russian"

class  ChupakabraTools::Transliterator

	def self.translify(str)
		str = str.to_s unless str.is_a?(String)
		Russian.transliterate(str)
	end

	def self.dirify(str)
		result_str = translify(str)
		result_str.gsub!(/(\s\&\s)|(\s\&amp\;\s)/, ' and ') # convert & to "and"
		result_str.gsub!(/\W/, ' ')  #replace non-chars
		result_str.gsub!(/(_)$/, '') #trailing underscores
		result_str.gsub!(/^(_)/, '') #leading unders
		result_str.strip.gsub(/(\s)/,'-').downcase.squeeze('-')
	end
end