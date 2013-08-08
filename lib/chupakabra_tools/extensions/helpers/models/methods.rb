# -*- encoding : utf-8 -*-
module ChupakabraTools
	module Extensions
		module Helpers
			module Models
				module Methods
					module PersonAge
						def age
							bd = nil
							the_age = nil
							if self.respond_to?(:birth_date) && (self.birth_date.is_a?(Date) || self.birth_date.is_a?(DateTime))
								bd = self.birth_date
							elsif self.respond_to?(:birthdate) && (self.birthdate.is_a?(Date) || self.birthdate.is_a?(DateTime))
								bd = self.birthdate
							end
							if bd
								the_age = Date.today.year - bd.year
								the_age -= 1 if Date.today < bd + the_age.years #for days before birthday
							end
							the_age
						end

						def next_birth_date
							bd = nil
							next_bd = nil
							if self.respond_to?(birth_date) && (self.birth_date.is_a?(Date) || self.birth_date.is_a?(DateTime))
								bd = self.birth_date
							elsif self.respond_to?(birthdate) && (self.birthdate.is_a?(Date) || self.birthdate.is_a?(DateTime))
								bd = self.birthdate
							end
							if bd
								next_bd = birth_date + (age+1).years
							end
							next_bd
						end

						def days_to_next_birth_date
							(next_birth_date - Date.today).to_s
						end

					end

					module PersonFullName
						def full_name

							nm = ""

							if self.respond_to?(:first_name)
								nm = self.first_name.to_s unless self.first_name.nil? || self.first_name.empty?
							elsif self.respond_to?(firstname)
								nm = self.firstname.to_s unless self.firstname.nil? || self.firstname.empty?
							end

							if self.respond_to?(:last_name)
								nm = last_name + ' ' + nm unless last_name.nil? || last_name.empty?
							elsif self.respond_to?(lastname)
								nm = last_name + ' ' + nm unless lastname.nil? || lastname.empty?
							end
							nm
						end
					end


				end
			end
		end
	end
end
