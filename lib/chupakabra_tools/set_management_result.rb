# -*- encoding : utf-8 -*-
require 'chupakabra_tools/active_enum_extended'

class ChupakabraTools::SetManagementResult < ::ChupakabraTools::ActiveEnumExtended
	value id: 1, name: I18n.t('chupakabra_tools.set_management_result.management_ok'), tag: 'management_ok'
	value id: 2, name: I18n.t('chupakabra_tools.set_management_result.set_not_found'), tag: 'set_not_found'
	value id: 3, name: I18n.t('chupakabra_tools.set_management_result.entry_no_found'), tag: 'entry_no_found'
	value id: 4, name: I18n.t('chupakabra_tools.set_management_result.purged'), tag: 'purged'
end
