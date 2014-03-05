module ChupakabraTools
	class FileType < ::ChupakabraTools::ActiveEnumExtended
		value id: 1, name: I18n.t("chupakabra_tools.file_types.image"), tag: "image"
		value id: 2, name: I18n.t("chupakabra_tools.file_types.video"), tag: "video"
		value id: 3, name: I18n.t("chupakabra_tools.file_types.audio"), tag: "audio"
		value id: 4, name: I18n.t("chupakabra_toolsn.file_types.pdf"), tag: "pdf"
		value id: 5, name: I18n.t("chupakabra_tools.file_types.word"), tag: "word"
		value id: 6, name: I18n.t("chupakabra_tools.file_types.excel"), tag: "excel"
		value id: 7, name: I18n.t("chupakabra_tools.file_types.html"), tag: "html"
		value id: 8, name: I18n.t("chupakabra_tools.file_types.xml"), tag: "xml"
		value id: 9, name: I18n.t("chupakabra_tools.file_types.text"), tag: "text"
	end
end