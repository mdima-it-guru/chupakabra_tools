# -*- encoding : utf-8 -*-

class ChupakabraTools::EducationLevel < ::SharedZone::ActiveEnumExtended
	value id: 1, name: I18n.t('chupakabra_tools.education_level.1'), tag: 'elementary_school'
	value id: 2, name: I18n.t('chupakabra_tools.education_level.2'), tag: 'high_school'
	value id: 3, name: I18n.t('chupakabra_tools.education_level.3'), tag: 'special'
	value id: 4, name: I18n.t('chupakabra_tools.education_level.4'), tag: 'college'
end
