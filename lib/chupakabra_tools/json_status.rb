# -*- encoding : utf-8 -*-
require 'chupakabra_tools/active_enum_extended'

class ChupakabraTools::JsonStatus < ::ChupakabraTools::ActiveEnumExtended
	value id: 1, name: I18n.t('chupakabra_tools.json_statuses.need_authentication'), tag: 'need_authentication'
	value id: 2, name: I18n.t('chupakabra_tools.json_statuses.ok'), tag: 'ok'
	value id: 3, name: I18n.t('chupakabra_tools.json_statuses.redirected'), tag: 'redirected'
	value id: 4, name: I18n.t('chupakabra_tools.json_statuses.access_denied'), tag: 'access_denied'
	value id: 5, name: I18n.t('chupakabra_tools.json_statuses.error'), tag: 'error'
	value id: 6, name: I18n.t('chupakabra_tools.json_statuses.not_found'), tag: 'not_found'
	value id: 7, name: I18n.t('chupakabra_tools.json_statuses.page_404'), tag: 'page_404'
end
