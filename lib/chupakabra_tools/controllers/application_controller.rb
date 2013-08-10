class ChupakabraTools::Controllers::ApplicationController < ActionController::Base


	include ChupakabraTools::Helpers::UrlHelper
	include ChupakabraTools::Helpers::BreadcrumbsHelper

	extend ::ChupakabraTools::Extensions::Helpers::Controllers::ObligatoryFilters::ClassMethods
	extend ::ChupakabraTools::Extensions::Helpers::Controllers::TransactionWrapper::ClassMethods




	def set_content_type
		content_type = case params[:format]
			               when "json"
				               "application/json"
			               when "xml"
				               "text/xml"
		               end
		headers["Content-Type"] = content_type
	end


	#########################################################################################################################
	#############################            I18n String Generator  Methods             #####################################
	#########################################################################################################################

	def self.to_i18n
		::ChupakabraTools::ClassHelper.controller_to_i18n(self)
	end

	def to_i18n
		self.class.to_i18n
	end

	#########################################################################################################################
	###############################            Routes Generator  Methods             ########################################
	#########################################################################################################################

	def self.to_route_path
		::ChupakabraTools::ClassHelper.controller_full_path_underscore(self)
	end

	def to_route_path
		self.class.to_route_path
	end

	#########################################################################################################################
	###############################            Obligatory Filters Methods            ########################################
	#########################################################################################################################

	def fill_obligatory_filters(filters, options)
		options ||= {}
		logger = options[:logger]
		logger.info("Fill Obligatory Filters: Controller Class: #{self.class}") if logger
		self.class.get_obligatory_filters.each do |ob_fi|
			#logger.info("Fill Obligatory Filters: filter_name: #{obligatory_filter[:name]}") if logger
			#logger.info("Fill Obligatory Filters: method_name: #{obligatory_filter[:source_method]}") if logger
			execute_flag = true

			if ob_fi[:source_method].nil?
				raise "Controller: #{self.class}\r\nObligatory Filter: #{ob_fi[:name]}\r\nERROR: 'source_method' not defined for obligatory filter '#{ob_fi[:name]}'"
			end

			unless ob_fi[:only].nil?
				execute_flag = false
				if ob_fi[:only].is_a?(String) || ob_fi[:only].is_a?(Symbol)
					if ob_fi[:only].to_s == self.action
						execute_flag = true
					end
				elsif ob_fi.is_a?(Array)
					ob_fi[:only].each do |ofo|
						if ofo.to_s == self.action
							execute_flag = true
						end
					end
				end
			end

			unless ob_fi[:skip].nil?
				if ob_fi[:skip].is_a?(String) || ob_fi[:skip].is_a?(Symbol)
					if ob_fi[:skip].to_s == self.action
						execute_flag = false
					end
				elsif ob_fi.is_a?(Array)
					ob_fi[:skip].each do |ofo|
						if ofo.to_s == self.action
							execute_flag = false
						end
					end
				end
			end

			filters[ob_fi[:name]] = self.send(ob_fi[:source_method]) if execute_flag == true
		end
	end

	def self.get_class_hierarchy
		classes_2_inspect = []
		classes_2_inspect.push(self)
		sc = self
		while (true) do
			sc = sc.superclass
			classes_2_inspect.push(sc)
			if sc == ApplicationController
				break
			end
		end
		classes_2_inspect
	end

	def self.get_obligatory_filters

		found_obligatory_filters=[]
		self.get_class_hierarchy.each do |cl|
			if cl.respond_to?(:obligatory_filters_set)
				cl.obligatory_filters_set.each do |filter|
					found_obligatory_filters.push(filter)
				end
			end
		end
		found_obligatory_filters
	end

	#########################################################################################################################
	######################################            Locale Methods            #############################################
	#########################################################################################################################


	def set_i18n_locale_from_params
		if params[:locale]
			if I18n.available_locales.include?(params[:locale].to_sym)
				I18n.locale = params[:locale]
				session[:locale] = params[:locale]
				cookies.permanent[:locale_set] = params[:locale]
			else
				if session[:locale]
					#params[:locale] = session[:locale]
					#I18n.locale = session[:locale]
					#locale_redirect(session[:locale])
					#redirect_to request.url  #, notice: "Translation \"#{params[:locale]}\" not available."
					#string_logger.error flash.now[:notice]
					redirect_to url_for(locale: session[:locale])
				elsif cookies[:locale_set]
					session[:locale] = cookies[:locale_set]
					params[:locale] = cookies[:locale_set]
					I18n.locale = cookies[:locale_set]
					#locale_redirect(session[:locale])
				else
					locale = get_best_locale
					params[:locale] = locale
					session[:locale] = locale
					cookies.permanent[:locale_set] = locale
					I18n.locale = locale
					#locale_redirect(I18n.locale)
				end
			end
		elsif session[:locale]
			redirect_to url_for(locale: session[:locale])
		elsif cookies[:locale_set]
			redirect_to url_for(locale: cookies[:locale_set])
		else
			redirect_to url_for(locale: get_best_locale)
		end
	end

	#def default_url_options
	#	{locale: I18n.locale}
	#end

	def check_locale_parameter
		if session[:locale]
			#if params[:locale]
			if I18n.available_locales.include?(params[:locale].to_sym)
				if params[:locale] != session[:locale]
					session[:locale] = params[:locale]
					I18n.locale = params[:locale]
				else
					I18n.locale = session[:locale]
				end
			else
				I18n.locale = session[:locale]
				redirect_to home_path, notice: :wrong_locale #"Translation \"#{params[:locale]}\" not available yet."
			end
		else
			I18n.locale = session[:locale]
			#redirect_to request.url, locale: I18n.locale
		end
		#else
		#  session[:locale] = I18n.locale
		#end
	end

	def get_best_locale
		locale = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first.to_sym
		if I18n.available_locales.include?(locale)
			locale
		else
			I18n.default_locale
		end
	end

end