require "chupakabra_tools/time_interval"
require "active_enum"

class ChupakabraTools::PredefinedTimeIntervals < ActiveEnum::Base
	value id: 1, name: I18n.t('chupakabra_tools.time_intervals.this_hour'), seo_tag: 'this_hour', time_line: 'present', scale: 'hour', value: ChupakabraTools::TimeInterval.this_hour
	value id: 2, name: I18n.t('chupakabra_tools.time_intervals.last_hour'), seo_tag: 'last_hour', time_line: 'past', scale: 'hour', value: ChupakabraTools::TimeInterval.previous_hour
	value id: 3, name: I18n.t('chupakabra_tools.time_intervals.next_hour'), seo_tag: 'next_hour', time_line: 'future', scale: 'hour', value: ChupakabraTools::TimeInterval.next_hour
	value id: 4, name: I18n.t('chupakabra_tools.time_intervals.today'), seo_tag: 'today', time_line: 'present', scale: 'day', value: ChupakabraTools::TimeInterval.today
	value id: 5, name: I18n.t('chupakabra_tools.time_intervals.tomorrow'), seo_tag: 'tomorrow', time_line: 'future', scale: 'day', value: ChupakabraTools::TimeInterval.tomorrow
	value id: 6, name: I18n.t('chupakabra_tools.time_intervals.yesterday'), seo_tag: 'yesterday', time_line: 'past', scale: 'day', value: ChupakabraTools::TimeInterval.yesterday
	value id: 7, name: I18n.t('chupakabra_tools.time_intervals.this_week'), seo_tag: 'this_week', time_line: 'present', scale: 'week', value: ChupakabraTools::TimeInterval.this_week
	value id: 8, name: I18n.t('chupakabra_tools.time_intervals.last_week'), seo_tag: 'last_week', time_line: 'past', scale: 'week', value: ChupakabraTools::TimeInterval.previous_week
	value id: 9, name: I18n.t('chupakabra_tools.time_intervals.next_week'), seo_tag: 'next_week', time_line: 'future', scale: 'week', value: ChupakabraTools::TimeInterval.next_week
	value id: 10, name: I18n.t('chupakabra_tools.time_intervals.this_month'), seo_tag: 'this_month', time_line: 'present', scale: 'month', value: ChupakabraTools::TimeInterval.this_month
	value id: 11, name: I18n.t('chupakabra_tools.time_intervals.last_month'), seo_tag: 'last_month', time_line: 'past', scale: 'month', value: ChupakabraTools::TimeInterval.previous_month
	value id: 12, name: I18n.t('chupakabra_tools.time_intervals.next_month'), seo_tag: 'next_month', time_line: 'future', scale: 'month', value: ChupakabraTools::TimeInterval.next_month
	value id: 13, name: I18n.t('chupakabra_tools.time_intervals.this_quarter'), seo_tag: 'this_quarter', time_line: 'present', scale: 'quarter', value: ChupakabraTools::TimeInterval.this_quarter
	value id: 14, name: I18n.t('chupakabra_tools.time_intervals.last_quarter'), seo_tag: 'last_quarter', time_line: 'past', scale: 'quarter', value: ChupakabraTools::TimeInterval.previous_quarter
	value id: 15, name: I18n.t('chupakabra_tools.time_intervals.next_quarter'), seo_tag: 'next_quarter', time_line: 'future', scale: 'quarter', value: ChupakabraTools::TimeInterval.next_quarter
	value id: 16, name: I18n.t('chupakabra_tools.time_intervals.this_year'), seo_tag: 'this_year', time_line: 'present', scale: 'year', value: ChupakabraTools::TimeInterval.this_year
	value id: 17, name: I18n.t('chupakabra_tools.time_intervals.last_year'), seo_tag: 'last_year', time_line: 'past', scale: 'year', value: ChupakabraTools::TimeInterval.previous_year
	value id: 18, name: I18n.t('chupakabra_tools.time_intervals.next_year'), seo_tag: 'next_year', time_line: 'future', scale: 'year', value: ChupakabraTools::TimeInterval.next_year
end