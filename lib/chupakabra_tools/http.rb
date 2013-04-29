module ChupakabraTools::Http
	def self.retrieve_operating_system(user_agent)
		unless user_agent
			"Unknown"
		end
		if user_agent.downcase.match(/mac/i)
			"MacOS"
		elsif user_agent.downcase.match(/windows/i)
			"Windows"
		elsif user_agent.downcase.match(/linux/i)
			"Linux"
		elsif user_agent.downcase.match(/unix/i)
			"Unix"
		else
			"Unknown"
		end
	end
end