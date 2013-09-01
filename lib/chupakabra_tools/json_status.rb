# -*- encoding : utf-8 -*-
require 'chupakabra_tools/active_enum_extended'

class ChupakabraTools::JsonStatus < ::ChupakabraTools::ActiveEnumExtended
	value id: 1, name: I18n.t('chupakabra_tools.json_statuses.1'), tag: 'need_authentication'
	value id: 2, name: I18n.t('chupakabra_tools.json_statuses.2'), tag: 'ok'
	value id: 3, name: I18n.t('chupakabra_tools.json_statuses.3'), tag: 'redirected'
	value id: 4, name: I18n.t('chupakabra_tools.json_statuses.4'), tag: 'access_denied'
	value id: 5, name: I18n.t('chupakabra_tools.json_statuses.5'), tag: 'error'
	value id: 6, name: I18n.t('chupakabra_tools.json_statuses.6'), tag: 'not_found'
end
