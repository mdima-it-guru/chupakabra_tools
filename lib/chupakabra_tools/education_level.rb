# -*- encoding : utf-8 -*-

class ChupakabraTools::EducationLevel < ::SharedZone::ActiveEnumExtended
	value id: 1, name: I18n.t("chupakabra_tools.education_levels.elementary_school"), tag: "elementary_school"
	value id: 2, name: I18n.t("chupakabra_tools.education_levels.high_school"), tag: "high_school"
	value id: 3, name: I18n.t("chupakabra_tools.education_levels.special"), tag: "special"
	value id: 4, name: I18n.t("chupakabra_tools.education_levels.college"), tag: "college"
end
