# -*- encoding : utf-8 -*-

module ChupakabraTools::Helpers::GuiHelper

	# Helpers to Draw url_for and Routes

	def switcher_tag(label, data, *args)
		options = args.extract_options!
		options ||= {}
		options.stringify_keys!

		value_off = options['value-off'] || "0"
		value_on = options['value-on'] || "1"

		off_input_options = {type: "radio", name: "#{label}", id: "#{label}-off", value: value_off, control_type: "switcher"}
		on_input_options = {type: "radio", name: "#{label}", id: "#{label}-on", value: value_on, control_type: "switcher"}

		if data == true
			on_input_options['checked'] = true
		else
			off_input_options['checked'] = true
		end

		toggle_options = {}

		toggle_options[:class] = "toggle" + (data == value_on ? ' on' : ' off')
		toggle_options[:class] = "toggle on"


		control_html =
			content_tag('div', class: "row-fluid") do
				content_tag('div', class: "pull-left") do
					content_tag('label', class: 'radio off') do
						tag('input', off_input_options)

					end +
						content_tag('label', class: 'radio on') do
							tag('input', on_input_options)
						end +
						content_tag('div', toggle_options) do
							content_tag('div', class: "yes") do
								options['label-on'] || 'ON'
							end +
								content_tag('div', class: "switch") do
								end +
								content_tag('div', class: "no") do
									options['label-off'] || 'OFF'
								end
						end
				end
			end
		control_html
	end


	def autocomplete_with_id_tag(id_value, text_value, path, options ={})
		options ||= {}
		options[:id] = SecureRandom.uuid.underscore unless options[:id]

		classes = options[:class] ? options[:class].to_s.split(' ') : []
		#classes.push ("input-append")
		#classes.push ("date")

		result = "".html_safe


		if path.is_a?(Hash)
			the_path = Rails.application.routes.url_helpers.url_for(path)
		else
			the_path = path

		end

		############################## CREATING HIDDEN ##########################

		hidden_options = {
			class: 'autocomplete',
			path: the_path,
			value: id_value,
			id: options[:id],
			type: "hidden",
			control_type: "autocomplete_wtih_id"
		}

		hidden_options[:parent_control_id] = options[:parent_control_id] if options[:parent_control_id]
		hidden_options[:name] = options[:name] if options[:name]
		hidden_options[:onchange] = options[:onchange].to_json if options[:onchange]
		hidden_options[:property_name] = options[:property_name] if options[:property_name]

		result += content_tag("input", "", hidden_options)

		############################## CREATING LINK ###########################
		link_classes = options[:class] ? options[:class].to_s.split(' ') : []
		link_options = {
			class: link_classes.join(" "),
			id: "#{options[:id]}_label"
		}

		#link_classes.push ("row-fluid")
		#classes.push ("input-append")
		#classes.push ("date")
		#link_classes.push ("error") if @object.errors[label].present?


		result += content_tag('a', text_value || options[:placeholder], link_options)

		############################# CREATING EDIT ############################

		edit_options = {
			class: classes.join(" "),
			id: "#{options[:id]}_edit",
			type: "text"
		}

		result += content_tag('input', '', edit_options)

		result
	end


	def date_picker_tag(params={})
		options = {}.merge(params)
		options[:id] = SecureRandom.uuid.underscore unless options[:id]

		classes = options[:class] ? options[:class].to_s.split(' ') : []
		classes.push ("date-picker") unless classes.include?("date-picker")
		options[:class] = classes.join(' ')

		options["data-date-format"] = options[:date_format] || "dd-mm-yyyy"
		options[:type] = "text"
		options[:value] = options[:value]
		options[:control_type] = "date_picker"

		content_tag('input', '', options)
	end


	def chosen_select_tag(choices, params = {})
		options = {}.merge(params)
		options[:id] = SecureRandom.uuid.underscore unless options[:id]

		classes = options[:class] ? options[:class].to_s.split(' ') : []
		classes.push ("chzn-select") unless classes.include?("chzn-select")
		options[:class] = classes.join(' ')
		options[:control_type] = "chosen_select"

		if options[:placeholder]
			options[:"data-placeholder"] = options[:placeholder]
			options[:placeholder] = nil
		end

		####################### BUILDING ONCHANGE COMMANDS #####################

		if options[:onchange]
			options[:onchange] = options[:onchange].to_json
		end

		#if options[:onchange]
		#	commands_set = []
		#	if options[:onchange].is_a?(Hash)
		#		commands_set.push(options[:onchange])
		#	elsif options[:onchange].is_a?(Array)
		#		options[:onchange].each do |command|
		#			if command.is_a?(Hash)
		#				commands_set.push(command)
		#			end
		#		end
		#	end
		#
		#	commands_set.each do |cmd_options|
		#		cmd_options[:id] = "#{options[:id]}_onchange_action"
		#		cmd_options[:style] = "display: none;"
		#		result += content_tag("div", "", cmd_options)
		#	end
		#end


		############################# BUILDING CHOICES #########################

		choices_html = ""
		if choices && choices.is_a?(Array)

			if options[:parent]
				if options[:parent_value].nil?
					options[:disabled] = "disabled"
				end
			end

			choices_html = content_tag('option', '', value: '')
			choices.each do |chs|
				choice_id = chs[1]
				choice_label = chs[0]
				choice_attributes = Hash.new
				choice_attributes[:value] = choice_id
				if options[:value]
					choice_attributes[:selected] = "selected" if choice_id.to_s == options[:value].to_s
				end

				choices_html += content_tag('option', choice_label, choice_attributes)
			end
		else
			options[:disabled] = "disabled"
		end


		content_tag('select', choices_html.html_safe, options)
	end

	def edit_tag(data, params = {})
		options = {}.merge(params)
		options[:id] = SecureRandom.uuid.underscore unless options[:id]

		classes = options[:class] ? options[:class].to_s.split(' ') : []
		#classes.push ("date-picker") unless classes.include?("date-picker")
		options[:class] = classes.join(' ')

		#options["data-date-format"] = options[:date_format] || "dd-mm-yyyy"
		options[:type] = "text"
		options[:value] = data
		options[:control_type] = "text_edit"

		if options[:tooltip]
			options[:rel] ="tooltip"
			options[:"data-placement"] = options[:tooltip_position] ? options[:tooltip_position].to_s : "rigth"
			options[:tooltip_position] = nil
			options["data-original-title"] = options[:tooltip]
			options[:tooltip] = nil
		end

		content_tag('input', '', options)
	end


	def left_menu_item_link(text, path, image_path, options = {})
		is_active = "current" if current_page?(path)

		content_tag('li', class: is_active) do
			content_tag("a", href: path, target: options[:target]) do
				tag('img', src: image_path, width: "16", height: "16", valign: "middle") +
					text
			end
		end
	end

	def left_menu_item_divider
		content_tag('li', "", class: "divider")
	end

	def left_menu_item_title(title)
		content_tag('li', class: "menuText") do
			"#{title}:"
		end
	end

	def left_menu_item_disabled(text, image_path)
		content_tag('li') do
			tag('img', src: image_path, width: "16", height: "16", valign: "middle") +
				text
		end
	end


end
