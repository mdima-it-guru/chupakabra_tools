require "active_support/all"

module ChupakabraTools
	class TimeInterval
		attr_accessor :beginning, :ending

		def initialize (interval_beginning, interval_ending)
			unless interval_beginning.is_a?(Time) || interval_beginning.is_a?(Date) || interval_beginning.is_a?(DateTime)
				raise "Begining of Interval is Not A Time, Date or DateTime value"
			end
			unless interval_ending.is_a?(Time) || interval_ending.is_a?(Date) || interval_ending.is_a?(DateTime)
				raise "End of Interval is Not A Time, Date or DateTime value"
			end

			@beginning = interval_beginning.to_time
			@ending = interval_ending.to_time
		end

		def beginning
			@beginning
		end

		def beginning= val
			@beginning = val
		end

		def ending
			@ending
		end

		def ending= val
			@ending = val
		end


		def to_s
			"#{@beginning} - #{@ending}"
		end

		def to_hash
			{beginning: @beginning, ending: @ending}
		end

		def to_json
			to_hash.to_json
		end

		def future?(time_zone = nil)
			!@beginning.nil? && @beginning > Time.now
		end

		def past?(time_zone = nil)
			!@ending.nil? && @ending < Time.now
		end

		def present?(time_zone = nil)
			!(is_past? || is_future?)
		end

		def valid?
			return false unless @beginning
			return false unless @ending
			@beginning < @ending
		end


		def time_line(time_zone = nil)
			return "future" if is_future?(time_zone)
			return "past" if is_past?(time_zone)
			"present"
		end


		def inverse!
			bg = @beginning
			en = @ending

			@beginning = en
			@ending = bg
			to_s
		end

		def add_hours!(number)
			@beginning += number.hours if @beginning
			@ending += number.hours if @ending
			to_s
		end

		def add_days!(number)
			@beginning += number.days if @beginning
			@ending += number.days if @ending
			to_s
		end

		def add_weeks!(number)
			@beginning += number.weeks if @beginning
			@ending += number.weeks if @ending
			to_s
		end

		def add_months!(number)
			@beginning += number.months if @beginning
			@ending += number.months if @ending
			to_s
		end

		def add_quarters!(number)
			@beginning += number.quarters if @beginning
			@ending += number.quarters if @ending
			to_s
		end

		def add_years!(number)
			@beginning += number.years if @beginning
			@ending += number.years if @ending
			to_s
		end


		def subtract_hours!(number)
			@beginning.ago(number.hours) if @beginning
			@ending.ago(number.hours) if @ending
			to_s
		end

		def subtract_days!(number)
			@beginning.ago(number.days) if @beginning
			@ending.ago(number.days) if @ending
			to_s
		end

		def subtract_weeks!(number)
			@beginning.ago(number.weeks) if @beginning
			@ending.ago(number.weeks) if @ending
			to_s
		end

		def subtract_months!(number)
			@beginning.ago(number.months) if @beginning
			@ending.ago(number.months) if @ending
			to_s
		end

		def subtract_quarters!(number)
			@beginning.ago(number.quarters) if @beginning
			@ending.ago(number.quarters) if @ending
			to_s
		end

		def subtract_years!(number)
			@beginning.ago(number.years) if @beginning
			@ending.ago(number.years) if @ending
			to_s
		end


		def inverse
			::ChupakabraTools::TimeInterval.new(@ending, @beginning)
		end

		def add_hours(number)
			new_beginning = @beginning + number.hours
			new_ending = @ending + number.hours
			::ChupakabraTools::TimeInterval.new(new_beginning, new_ending)
		end

		def add_days(number)
			new_beginning = @beginning + number.days
			new_ending = @ending + number.days
			::ChupakabraTools::TimeInterval.new(new_beginning, new_ending)
		end

		def add_weeks(number)
			new_beginning = @beginning + number.weeks
			new_ending = @ending + number.weeks
			::ChupakabraTools::TimeInterval.new(new_beginning, new_ending)
		end

		def add_months(number)
			new_beginning = @beginning + number.months
			new_ending = @ending + number.months
			::ChupakabraTools::TimeInterval.new(new_beginning, new_ending)
		end

		def add_quarters(number)
			new_beginning = @beginning + number.quarters
			new_ending = @ending + number.quarters
			::ChupakabraTools::TimeInterval.new(new_beginning, new_ending)
		end

		def add_years(number)
			new_beginning = @beginning + number.years
			new_ending = @ending + number.years
			::ChupakabraTools::TimeInterval.new(new_beginning, new_ending)
		end


		def subtract_hours(number)
			new_beginning = @beginning.ago(number.hours)
			new_ending = @ending.ago(number.hours)
			::ChupakabraTools::TimeInterval.new(new_beginning, new_ending)
		end

		def subtract_days(number)
			new_beginning = @beginning.ago(number == 1 ? 1.day : number.days)
			new_ending = @ending.ago(number == 1 ? 1.day : number.days)
			::ChupakabraTools::TimeInterval.new(new_beginning, new_ending)
		end

		def subtract_weeks(number)
			new_beginning = @beginning.ago(number.weeks)
			new_ending = @ending.ago(number.weeks)
			::ChupakabraTools::TimeInterval.new(new_beginning, new_ending)
		end

		def subtract_months(number)
			new_beginning = @beginning.ago(number.months)
			new_ending = @ending.ago(number.months)
			::ChupakabraTools::TimeInterval.new(new_beginning, new_ending)
		end

		def subtract_quarters(number)
			new_beginning = @beginning.ago(number.quarters)
			new_ending = @ending.ago(number.quarters)
			::ChupakabraTools::TimeInterval.new(new_beginning, new_ending)
		end

		def subtract_years(number)
			new_beginning = @beginning.ago(number.years)
			new_ending = @ending.ago(number.years)
			::ChupakabraTools::TimeInterval.new(new_beginning, new_ending)
		end


		# ************************************** HOURs **********************************

		def self.this_hour(time_zone = nil)
			hour(Time.now, time_zone)
		end

		def self.previous_hour(definite_time = nil, time_zone = nil)
			hour(definite_time, time_zone).subtract_hours(1)
		end

		def self.next_hour(definite_time = nil, time_zone = nil)
			hour(definite_time, time_zone).add_hours(1)
		end

		def self.hour(definite_time = nil, time_zone = nil)
			if definite_time
				definite_time = definite_time.to_time if definite_time.is_a?(Date)
				if definite_time.is_a?(Integer)

					definite_time = definite_time == 0 ? definite_time : (definite_time.abs - 1)
					definite_time = Time.new(Time.now.year, Time.now.month, Time.now.day, definite_time, 0, 0)
				end

			end
			time = (definite_time.nil? || !definite_time.is_a?(Time) ? Time.now : definite_time)

			::ChupakabraTools::TimeInterval.new(time.beginning_of_hour, time.end_of_hour)
		end


		# ************************************* DAYS *****************************************

		def self.tomorrow(time_zone = nil)
			next_day(Time.now, time_zone)
		end

		def self.yesterday(time_zone = nil)
			previous_day(Time.now, time_zone)
		end

		def self.today(time_zone = nil)
			day(Time.now, time_zone)
		end


		def self.next_day(definite_time, time_zone = nil)
			day(definite_time, time_zone).add_days(1)
		end

		def self.previous_day(definite_time, time_zone = nil)
			day(definite_time, time_zone).subtract_days(1)
		end

		def self.day(definite_time = nil, time_zone = nil)
			if definite_time
				definite_time = definite_time.to_time if definite_time.is_a?(Date)
				if definite_time.is_a?(Integer)
					definite_time = definite_time == 0 ? definite_time : (definite_time.abs - 1)
					definite_time = Time.new(Time.now.year, 1, 1) + definite_time.days
				end
			end

			time = (definite_time.nil? || !definite_time.is_a?(Time) ? Time.now : definite_time)

			::ChupakabraTools::TimeInterval.new(time.beginning_of_day, time.end_of_day)
		end


		# ************************************** WEEKS **********************************

		def self.this_week(time_zone = nil)
			week(Time.now, time_zone)
		end

		def self.last_week(time_zone = nil)
			previous_week(Time.now, time_zone)
		end

		def self.previous_week(definite_time = nil, time_zone = nil)
			week(definite_time, time_zone).subtract_weeks(1)
		end

		def self.next_week(definite_time = nil, time_zone = nil)
			week(definite_time, time_zone).add_weeks(1)
		end

		def self.week(definite_time = nil, time_zone = nil)
			if definite_time
				definite_time = definite_time.to_time if definite_time.is_a?(Date)
			end
			time = (definite_time.nil? || !definite_time.is_a?(Time) ? Time.now : definite_time)

			::ChupakabraTools::TimeInterval.new(time.beginning_of_week, time.end_of_week)
		end

		# ************************************** MONTHS **********************************

		def self.this_month(time_zone = nil)
			month(Time.now, time_zone)
		end

		def self.last_month(time_zone = nil)
			month(Time.now.ago(1.month), time_zone)
		end

		def self.previous_month(definite_time = nil, time_zone = nil)
			if definite_time
				definite_time = definite_time.to_time if definite_time.is_a?(Date)
				definite_time = Time.new(Time.now.year, definite_time, 1) if definite_time.is_a?(Integer)
			end
			time = (definite_time.nil? || !definite_time.is_a?(Time) ? Time.now : definite_time).ago(1.month)

			::ChupakabraTools::TimeInterval.new(time.beginning_of_month, time.end_of_month)
		end

		def self.next_month(definite_time = nil, time_zone = nil)
			if definite_time
				definite_time = definite_time.to_time if definite_time.is_a?(Date)
				definite_time = Time.new(Time.now.year, definite_time, 1) if definite_time.is_a?(Integer)
			end
			time = (definite_time.nil? || !definite_time.is_a?(Time) ? Time.now : definite_time) + 1.month

			::ChupakabraTools::TimeInterval.new(time.beginning_of_month, time.end_of_month)
		end

		def self.month(definite_time = nil, time_zone = nil)
			if definite_time
				definite_time = definite_time.to_time if definite_time.is_a?(Date)
				definite_time = Time.new(Time.now.year, definite_time, 1) if definite_time.is_a?(Integer)
			end
			time = (definite_time.nil? || !definite_time.is_a?(Time) ? Time.now : definite_time)

			::ChupakabraTools::TimeInterval.new(time.beginning_of_month, time.end_of_month)
		end

		def self.month_of_year(month, year, time_zone = nil)
			time = Time.new(year, month, 1)
			::ChupakabraTools::TimeInterval.new(time.beginning_of_month, time.end_of_month)
		end


		# ************************************** QUARTERS **********************************

		def self.last_quarter(time_zone = nil)
			previous_quarter(Time.now, time_zone)
		end

		def self.this_quarter(time_zone = nil)
			quarter(Time.now, time_zone)
		end


		def self.previous_quarter(definite_time = nil, time_zone = nil)
			if definite_time
				definite_time = definite_time.to_time if definite_time.is_a?(Date)
				definite_time = Time.new(Time.now.year, (definite_time - 1) * 3 + 1, 1, 0, 0) if definite_time.is_a?(Integer)
			end
			time = (definite_time.nil? || !definite_time.is_a?(Time) ? Time.now : definite_time).ago(3.months)

			::ChupakabraTools::TimeInterval.new(time.beginning_of_quarter, time.end_of_quarter)
		end

		def self.next_quarter(definite_time = nil, time_zone = nil)
			if definite_time
				definite_time = definite_time.to_time if definite_time.is_a?(Date)
				definite_time = Time.new(Time.now.year, (definite_time - 1) * 3 + 1, 1, 0, 0) if definite_time.is_a?(Integer)
			end
			time = (definite_time.nil? || !definite_time.is_a?(Time) ? Time.now : definite_time) + 3.months
			::ChupakabraTools::TimeInterval.new(time.beginning_of_quarter, time.end_of_quarter)
		end

		def self.quarter(definite_time = nil, time_zone = nil)
			if definite_time
				definite_time = definite_time.to_time if definite_time.is_a?(Date)
				definite_time = Time.new(Time.now.year, (definite_time - 1) * 3 + 1, 1, 0, 0) if definite_time.is_a?(Integer)
			end
			time = (definite_time.nil? || !definite_time.is_a?(Time) ? Time.now : definite_time)

			::ChupakabraTools::TimeInterval.new(time.beginning_of_quarter, time.end_of_quarter)
		end


		# ************************************** YEARS **********************************

		def self.last_year(time_zone = nil)
			previous_year(Time.now, time_zone)
		end

		def self.this_year(time_zone = nil)
			year(Time.now, time_zone)
		end


		def self.previous_year(definite_time = nil, time_zone = nil)
			if definite_time
				definite_time = definite_time.to_time if definite_time.is_a?(Date)
				definite_time = Time.new(definite_time, 1, 1, 0, 0) if definite_time.is_a?(Integer)
			end
			time = (definite_time.nil? || !definite_time.is_a?(Time) ? Time.now : definite_time).ago(1.year)

			::ChupakabraTools::TimeInterval.new(time.beginning_of_year, time.end_of_year)
		end

		def self.next_year(definite_time = nil, time_zone = nil)
			if definite_time
				definite_time = definite_time.to_time if definite_time.is_a?(Date)
				definite_time = Time.new(definite_time, 1, 1, 0, 0) if definite_time.is_a?(Integer)
			end
			time = (definite_time.nil? || !definite_time.is_a?(Time) ? Time.now : definite_time) + 1.year
			::ChupakabraTools::TimeInterval.new(time.beginning_of_year, time.end_of_year)
		end

		def self.year(definite_time = nil, time_zone = nil)
			if definite_time
				definite_time = definite_time.to_time if definite_time.is_a?(Date)
				definite_time = Time.new(definite_time, 1, 1, 0, 0) if definite_time.is_a?(Integer)
			end
			time = (definite_time.nil? || !definite_time.is_a?(Time) ? Time.now : definite_time)

			::ChupakabraTools::TimeInterval.new(time.beginning_of_year, time.end_of_year)
		end


		# ::ChupakabraTools::TimeInterval.new(beginning: , ending:  )

		def self.get_time_interval(interval_request, time = nil)
			interval = nil
			if interval_request
				if time.nil?

					interval_request = interval_request.to_s.strip.downcase

					if ['today', 'this_day', 'this-day', 'this day'].include?(interval_request)
						interval = ::ChupakabraTools::TimeInterval.today
					elsif ['yesterday', 'previous_day', 'previous_day', 'previous_day'].include?(interval_request)
						interval = ::ChupakabraTools::TimeInterval.yesterday
					elsif ['tomorrow', 'next_day', 'next-day', 'next day'].include?(interval_request)
						interval = ::ChupakabraTools::TimeInterval.tomorrow
					elsif ['this_week', 'this-week', 'this week'].include?(interval_request)
						interval = ::ChupakabraTools::TimeInterval.this_week
					elsif ['last_week', 'last-week', 'last week'].include?(interval_request)
						interval = ::ChupakabraTools::TimeInterval.last_week
					elsif ['next_week', 'next-week', 'next week'].include?(interval_request)
						interval = ::ChupakabraTools::TimeInterval.next_week
					elsif ['this_month', 'this-month', 'this month'].include?(interval_request)
						interval = ::ChupakabraTools::TimeInterval.this_month
					elsif ['last_month', 'last-month', 'last month', 'previous_month', 'previous-month', 'previous month'].include?(interval_request)
						interval = ::ChupakabraTools::TimeInterval.last_month
					elsif ['next_month', 'next-month', 'next month'].include?(interval_request)
						interval = ::ChupakabraTools::TimeInterval.next_month
					elsif ['this_quarter', 'this-quarter', 'this quarter'].include?(interval_request)
						interval = ::ChupakabraTools::TimeInterval.this_quarter
					elsif ['last_quarter', 'last-quarter', 'last quarter', 'previous_quarter', 'previous-quarter', 'previous quarter'].include?(interval_request)
						interval = ::ChupakabraTools::TimeInterval.last_quarter
					elsif ['next_quarter', 'next-quarter', 'next quarter'].include?(interval_request)
						interval = ::ChupakabraTools::TimeInterval.next_quarter
					elsif ['this_year', 'this-year', 'this year'].include?(interval_request)
						interval = ::ChupakabraTools::TimeInterval.this_year
					elsif ['last_year', 'last-year', 'last year', 'previous_year', 'previous-year', 'previous year'].include?(interval_request)
						interval = ::ChupakabraTools::TimeInterval.last_year
					elsif ['next_year', 'next-year', 'next year'].include?(interval_request)
						interval = ::ChupakabraTools::TimeInterval.next_year
					end
				else
					if time.is_a?(Date)
						time = time.to_time
					end

					if ['this_day', 'this-day', 'this day'].include?(interval_request)
						interval = ::ChupakabraTools::TimeInterval.this_day(time)
					elsif ['previous_day', 'previous_day', 'previous_day'].include?(interval_request)
						interval = ::ChupakabraTools::TimeInterval.previous_day(time)
					elsif ['next_day', 'next-day', 'next day'].include?(interval_request)
						interval = ::ChupakabraTools::TimeInterval.next_day(time)
					elsif ['this_week', 'this-week', 'this week'].include?(interval_request)
						interval = ::ChupakabraTools::TimeInterval.this_week
					elsif ['last_week', 'last-week', 'last week'].include?(interval_request)
						interval = ::ChupakabraTools::TimeInterval.last_week
					elsif ['next_week', 'next-week', 'next week'].include?(interval_request)
						interval = ::ChupakabraTools::TimeInterval.next_week
					elsif ['this_month', 'this-month', 'this month'].include?(interval_request)
						interval = ::ChupakabraTools::TimeInterval.this_month
					elsif ['last_month', 'last-month', 'last month', 'previous_month', 'previous-month', 'previous month'].include?(interval_request)
						interval = ::ChupakabraTools::TimeInterval.last_month
					elsif ['next_month', 'next-month', 'next month'].include?(interval_request)
						interval = ::ChupakabraTools::TimeInterval.next_month
					elsif ['this_quarter', 'this-quarter', 'this quarter'].include?(interval_request)
						interval[:start] = ::ChupakabraTools::TimeInterval.this_quarter
					elsif ['last_quarter', 'last-quarter', 'last quarter', 'previous_quarter', 'previous-quarter', 'previous quarter'].include?(interval_request)
						interval = ::ChupakabraTools::TimeInterval.last_quarter
					elsif ['next_quarter', 'next-quarter', 'next quarter'].include?(interval_request)
						interval = ::ChupakabraTools::TimeInterval.next_quarter
					elsif ['this_year', 'this-year', 'this year'].include?(interval_request)
						interval[:start] = ::ChupakabraTools::TimeInterval.this_year
					elsif ['last_year', 'last-year', 'last year', 'previous_year', 'previous-year', 'previous year'].include?(interval_request)
						interval = ::ChupakabraTools::TimeInterval.last_year
					elsif ['next_year', 'next-year', 'next year'].include?(interval_request)
						interval = ::ChupakabraTools::TimeInterval.next_year
					end
				end
			else
				nil
			end
			interval
		end

	end
end