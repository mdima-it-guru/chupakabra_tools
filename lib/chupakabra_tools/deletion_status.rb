# -*- encoding : utf-8 -*-
class ChupakabraTools::DeletionStatus < ::ChupakabraTools::ActiveEnumExtended
	value id: 1, name: I18n.t('chupakabra_tools.deletion_statuses.1'), tag: 'actual'
	value id: 2, name: I18n.t('chupakabra_tools.deletion_statuses.2'), tag: 'deleted'
	value id: 3, name: I18n.t('chupakabra_tools.deletion_statuses.3'), tag: 'purged'
end
