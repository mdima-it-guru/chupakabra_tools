require 'chupakabra_tools/active_enum_extended'

class ChupakabraTools::DataType < ::ChupakabraTools::ActiveEnumExtended
	value id: 1, name: I18n.t('chupakabra_tools.data_types.integer'), tag: 'integer'
	value id: 2, name: I18n.t('chupakabra_tools.data_types.string'), tag: 'string'
	value id: 3, name: I18n.t('chupakabra_tools.data_types.boolean'), tag: 'boolean'
	value id: 4, name: I18n.t('chupakabra_tools.data_types.text'), tag: 'text'
	value id: 5, name: I18n.t('chupakabra_tools.data_types.decimal'), tag: 'decimal'
	value id: 6, name: I18n.t('chupakabra_tools.data_types.date'), tag: 'date'
	value id: 7, name: I18n.t('chupakabra_tools.data_types.datetime'), tag: 'datetime'

end
