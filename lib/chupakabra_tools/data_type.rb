require 'chupakabra_tools/active_enum_extended'

class ChupakabraTools::DataType < ::ChupakabraTools::ActiveEnumExtended
	value id: 1, name: I18n.t('chupakabra_tools.data_types.1'), tag: 'integer'
	value id: 2, name: I18n.t('chupakabra_tools.data_types.2'), tag: 'string'
	value id: 3, name: I18n.t('chupakabra_tools.data_types.3'), tag: 'boolean'
	value id: 4, name: I18n.t('chupakabra_tools.data_types.4'), tag: 'text'
	value id: 5, name: I18n.t('chupakabra_tools.data_types.5'), tag: 'decimal'
	value id: 6, name: I18n.t('chupakabra_tools.data_types.6'), tag: 'date'
	value id: 7, name: I18n.t('chupakabra_tools.data_types.7'), tag: 'datetime'

end
