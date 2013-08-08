# -*- encoding : utf-8 -*-
require 'chupakabra_tools/active_enum_extended'

class ChupakabraTools::SetManagementResult < ::ChupakabraTools::ActiveEnumExtended
	value id: 1, name: I18n.t('chupakabra_tools.set_management_result.1'), tag: 'management_ok'
	value id: 2, name: I18n.t('chupakabra_tools.set_management_result.2'), tag: 'set_not_found'
	value id: 3, name: I18n.t('chupakabra_tools.set_management_result.3'), tag: 'entry_no_found'
	value id: 4, name: I18n.t('chupakabra_tools.set_management_result.4'), tag: 'purged'
end
