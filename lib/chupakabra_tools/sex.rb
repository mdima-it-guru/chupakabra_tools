# -*- encoding : utf-8 -*-

class ChupakabraTools::Sex < ::ChupakabraTools::ActiveEnumExtended
	value id: 1, name: I18n.t("chupakabra_tools.sexes.male"), tag: 'male'
	value id: 2, name: I18n.t("chupakabra_tools.sexes.female"), tag: 'female'
end
