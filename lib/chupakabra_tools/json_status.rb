# -*- encoding : utf-8 -*-
require 'chupakabra_tools/active_enum_extended'

# <b>DEPRECATED:</b> class <tt>ChupakabraTools::JsonStatus</tt> is depricated. Please use <tt>ChupakabraTools::ApiStatus</tt> instead.
class ChupakabraTools::JsonStatus < ::ChupakabraTools::ActiveEnumExtended
	value id: 0, name: I18n.t("chupakabra_tools.api_statuses.unknown"), tag: 'unknown'
	value id: 1, name: I18n.t("chupakabra_tools.api_statuses.need_authentication"), tag: 'need_authentication'
	value id: 2, name: I18n.t("chupakabra_tools.api_statuses.ok"), tag: 'ok'
	value id: 3, name: I18n.t("chupakabra_tools.api_statuses.redirected"), tag: 'redirected'
	value id: 4, name: I18n.t("chupakabra_tools.api_statuses.access_denied"), tag: 'access_denied'
	value id: 5, name: I18n.t("chupakabra_tools.api_statuses.error"), tag: 'error'
	value id: 6, name: I18n.t("chupakabra_tools.api_statuses.record_not_found"), tag: 'record_not_found'
	value id: 7, name: I18n.t("chupakabra_tools.api_statuses.page_404"), tag: 'page_404'
	value id: 8, name: I18n.t("chupakabra_tools.api_statuses.database_error"), tag: 'database_error'
	value id: 9, name: I18n.t("chupakabra_tools.api_statuses.user_not_found"), tag: 'user_not_found'
	value id: 10, name: I18n.t("chupakabra_tools.api_statuses.app_not_found"), tag: "app_not_found"
	value id: 11, name: I18n.t("chupakabra_tools.api_statuses.http_error"), tag: "http_error"
	value id: 12, name: I18n.t("chupakabra_tools.api_statuses.json_response_error"), tag: "json_response_error"
	value id: 13, name: I18n.t("chupakabra_tools.api_statuses.internal_error"), tag: "internal_error"
end