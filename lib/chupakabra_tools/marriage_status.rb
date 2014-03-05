# -*- encoding : utf-8 -*-

class ChupakabraTools::MarriageStatus < ::ChupakabraTools::ActiveEnumExtended
	value id: 1, name: I18n.t("chupakabra_tools.marriage_statuses.statuses.unknown"), tag: 'unknown'
	value id: 2, name: I18n.t("chupakabra_tools.marriage_statuses.statuses.single"), tag: 'single'
	value id: 3, name: I18n.t("chupakabra_tools.marriage_statuses.statuses.in_relations"), tag: 'in_relations'
	value id: 4, name: I18n.t("chupakabra_tools.marriage_statuses.statuses.married"), tag: 'married'
	value id: 5, name: I18n.t("chupakabra_tools.marriage_statuses.statuses.divorced"), tag: 'divorced'
	value id: 6, name: I18n.t("chupakabra_tools.marriage_statuses.statuses.widow"), tag: 'widow'
end
