# -*- encoding : utf-8 -*-

require 'chupakabra_tools/helpers/gui_helper'

class ChupakabraTools::KirguduFormBuilder < ActionView::Helpers::FormBuilder

	include ActionView::Helpers::AssetTagHelper
	include ActionView::Helpers::TagHelper

	include ::ChupakabraTools::Helpers::GuiHelper

	def error_label(label, *args)
		options = args.extract_options!
		options.merge!(class: "error", generated: "true", style: "display: block")
		errors_in_html = ""
		if @object.errors[label].present?
			@object.errors[label].each do |error_message|
				errors_in_html += @template.content_tag("label", error_message.capitalize.html_safe, options)
			end
		end
		errors_in_html.html_safe
	end

	def label_with_hint(label, hint, *args)
		@template.content_tag("label", (@object.class.human_attribute_name(label) + @template.content_tag("span", hint, class: 'help-block')).html_safe, *args)
	end

	def label(label, *args)
		@template.content_tag("label", *args) do
			@object.class.human_attribute_name(label)
		end
	end


	def text_field(label, *args)
		options = args.extract_options!

		classes = options[:class] ? options[:class].to_s.split(' ') : []
		classes.push ("error") if @object.errors[label].present? && !classes.include?("error")
		options[:class] = classes.join(" ")

		options[:id] = "#{@object_name}_#{label}"
		options[:name] = "#{@object_name}[#{label}]"

		super(label, options)
	end

	def text_edit(label, *args)
		options = args.extract_options!

		classes = options[:class] ? options[:class].to_s.split(' ') : []
		classes.push ("error") if @object.errors[label].present? && !classes.include?("error")
		options[:class] = classes.join(" ")

		options[:id] = "#{@object_name}_#{label}"
		options[:name] = "#{@object_name}[#{label}]"

		edit_tag(@object[label], options)
	end

	def text_area(label, *args)
		options = args.extract_options!

		classes = options[:class] ? options[:class].to_s.split(' ') : []
		classes.push ("error") if @object.errors[label].present? && !classes.include?("error")
		options[:class] = classes.join(" ")

		options.merge!(rows: '5') unless options.include?(:rows)

		super(label, options)
	end


	def password_field(label, *args)
		options = args.extract_options!

		classes = options[:class] ? options[:class].to_s.split(' ') : []
		classes.push ("error") if @object.errors[label].present? && !classes.include?("error")
		options[:class] = classes.join(" ")

		super(label, options)
	end

	def autocomplete_field(label, *args)
		options = args.extract_options!

		classes = options[:class] ? options[:class].to_s.split(' ') : []
		classes.push ("error") if @object.errors[label].present? && !classes.include?("error")
		options[:class] = classes.join(" ")
	end


	def autocomplete_with_id(label, text_value, path, options = {})
		options ||= {}

		classes = options[:class] ? options[:class].to_s.split(' ') : []
		classes.push ("error") if @object.errors[label].present? && !classes.include?("error")
		options[:class] = classes.join(" ")

		options[:id] = "#{@object_name}_#{label}"
		options[:name] = "#{@object_name}[#{label}]"
		options[:property_name] = label

		if options[:parent]
			options[:parent_control_id] = "#{@object_name}_#{options[:parent]}"
			options[:parent] = nil
		end

		if options[:onchange]

			onchange_actions = []

			if options[:onchange].is_a?(Hash)
				onchange_actions.push(options[:onchange])
			elsif options[:onchange].is_a?(Array)
				options[:onchange].each do |a|
					onchange_actions.push(a)
				end
			end

			onchange_actions.each do |o|
				o[:property_control] = "#{@object_name}_#{o[:property]}"
			end

			options[:onchange] = onchange_actions
		end

		autocomplete_with_id_tag(@object[label], text_value, path, options)
	end


	def date_picker(label, *args)
		options = args.extract_options!

		#raise options.to_json

		classes = options[:class] ? options[:class].to_s.split(' ') : []
		classes.push ("error") if @object.errors[label].present?
		options[:class] = classes.join(' ')

		options[:id] = "#{@object_name}_#{label}"
		options[:name] = "#{@object_name}[#{label}]"
		options[:value] = @object[label]

		date_picker_tag(options)
	end

	#def date_picker_with_icon(label, *args)
	#
	#	options = args.extract_options!
	#	classes = Array.new
	#	classes.push ("row-fluid")
	#	classes.push ("input-append")
	#	classes.push ("date")
	#	classes.push ("error") if @object.errors[label].present?
	#	options.merge!(class: classes.join(" "))
	#	options.merge!(id: "datepicker_#{@object_name}_#{label}")
	#	options.merge!("data-date" => @object.instance_values[label])
	#	options.merge!("data-date-format" => "dd-mm-yyyy")
	#
	#	result = @template.content_tag("div", options) do
	#		    text_field(label, class: 'row-fluid') +
	#			@template.content_tag('span', class: 'add-on') do
	#				@template.content_tag('i', class: 'icon-th') do
	#				end
	#			end
	#		end
	#	js="<script type=\"text/javascript\">
	#         $(document).ready(function(){
	#           $('#datepicker_#{@object_name}_#{label}').datepicker();
	#          });
	#      </script>"
	#	result + js.html_safe
	#
	#end

	def elastic_textarea(label, *args)
		options = args.extract_options!

		classes = options[:class] ? options[:class].to_s.split(' ') : []
		classes.push ("autogrow") if !classes.include?("autogrow")
		options[:class] = classes.join(" ")

		text_area(label, options)
	end


	def color_picker(label, *args)
		options = args.extract_options!

		classes = options[:class] ? options[:class].to_s.split(' ') : []
		classes.push ("color-picker") if !classes.include?("color-picker")
		options[:class] = classes.join(" ")

		text_field(label, args)
	end

	def masked_field

	end

	def chosen_select(label, choices, *args)

		options = args.extract_options!

		classes = options[:class] ? options[:class].to_s.split(' ') : []
		classes.push ("error") if @object.errors[label].present?
		options[:class] = classes.join(' ')

		options[:id] = "#{@object_name}_#{label}"
		options[:name] = "#{@object_name}[#{label}]"
		options[:value] = @object[label]
		options[:property_name] = label


		if options[:onchange]
			onchange_actions = []
			if options[:onchange].is_a?(Hash)
				onchange_actions.push(options[:onchange])
			elsif options[:onchange].is_a?(Array)
				options[:onchange].each do |a|
					onchange_actions.push(a)
				end
			end

			onchange_actions.each do |o|
				o[:property_control] = "#{@object_name}_#{o[:property]}"

				if o[:source] && o[:source].is_a?(Hash)
					o[:source] = Rails.application.routes.url_helpers.url_for(o[:source])
				end
			end

			options[:onchange] = onchange_actions
		end

		if options[:parent]
			options[:parent_value] = @object[options[:parent]]
		end


		chosen_select_tag(choices, options)

	end


	def choose_image(label, thumb_url, *args)
		options = args.extract_options!


		image_options = Hash.new
		image_options[:src] = thumb_url
		image_options[:id] = "#{@object_name}_#{label}_selected_image"
		image_options[:style] ='display: none' unless @object[label]

		control_html = @template.content_tag('img', '', image_options) + '<br/>'.html_safe

		select_image_options = Hash.new
		select_image_options[:href] = "javascript:showImageSelectDialog('##{@object_name}_#{label}_imagesModal'); return false;"

		control_html += @template.content_tag('a', select_image_options) do
			"Select Image"
		end

		hidden_options = Hash.new
		hidden_options[:type] = 'hidden'
		hidden_options[:id] ="#{@object_name}_#{label}"
		hidden_options[:name] = "#{@object_name}[#{label}]"
		hidden_options[:value] = @object[label].to_s if @object[label]

		control_html += @template.content_tag('input', '', hidden_options)

		control_html
	end


	def radio_group(label, values, *args)
		control_html = ""
		values.each do |value_pair|
			control_html +=
				@template.content_tag('label', class: "radio") do
					@template.content_tag('div', class: "radio") do
						@template.content_tag('span', class: '') do
							@template.tag('input', type: 'radio', name: "#{@object_name}[#{label}]", id: "#{@object_name}_#{label}", value: value_pair[1], style: 'opacity: 0;')
						end
					end +
						value_pair[0]
				end
		end
		control_html.html_safe
	end


	def switcher(label, *args)
		options = args.extract_options!
		options ||= {}
		options.stringify_keys!

		value_off = options['value-off'] || "0"
		value_on = options['value-on'] || "1"

		off_input_options = {type: "radio", name: "#{@object_name}[#{label}]", id: "#{@object_name}-#{label}-off", value: value_off}
		on_input_options = {type: "radio", name: "#{@object_name}[#{label}]", id: "#{@object_name}-#{label}-on", value: value_on}

		if @object[label] == true
			on_input_options['checked'] = true
		else
			off_input_options['checked'] = true
		end

		toggle_options = {}

		toggle_options[:class] = "toggle" + (@object[label] == value_on ? ' on' : ' off')
		toggle_options[:class] = "toggle on"


		control_html =
			@template.content_tag('div', class: "row-fluid") do
				@template.content_tag('div', class: "pull-left") do
					@template.content_tag('label', class: 'radio off') do
						@template.tag('input', off_input_options)

					end +
						@template.content_tag('label', class: 'radio on') do
							@template.tag('input', on_input_options)
						end +
						@template.content_tag('div', toggle_options) do
							@template.content_tag('div', class: "yes") do
								options['label-on'] || 'ON'
							end +
								@template.content_tag('div', class: "switch") do
								end +
								@template.content_tag('div', class: "no") do
									options['label-off'] || 'OFF'
								end
						end
				end
			end
		control_html
	end
end
