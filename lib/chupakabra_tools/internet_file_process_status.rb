class ChupakabraTools::InternetFileProcessStatus < ::ChupakabraTools::ActiveEnumExtended
	value id: 1, name: I18n.t('chupakabra_tools.internet_file_process_status.1'), tag: 'not_processed'
	value id: 2, name: I18n.t('chupakabra_tools.internet_file_process_status.2'), tag: 'downloading'
	value id: 3, name: I18n.t('chupakabra_tools.internet_file_process_status.3'), tag: 'download_error'
	value id: 4, name: I18n.t('chupakabra_tools.internet_file_process_status.4'), tag: 'downloaded'
	value id: 5, name: I18n.t('chupakabra_tools.internet_file_process_status.5'), tag: 'parsing'
	value id: 6, name: I18n.t('chupakabra_tools.internet_file_process_status.6'), tag: 'parse_error'
	value id: 7, name: I18n.t('chupakabra_tools.internet_file_process_status.7'), tag: 'parsed'
end