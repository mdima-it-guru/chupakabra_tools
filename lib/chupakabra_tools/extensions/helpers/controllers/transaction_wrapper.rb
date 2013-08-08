# -*- encoding : utf-8 -*-

module ChupakabraTools
	module Extensions
		module Helpers
			module Controllers
				module TransactionWrapper
					module ClassMethods
						def in_transaction_before_create(method, options = {})
							in_transaction_set_filter(:before_create, method, options)
						end

						def in_transaction_after_create(method, options = {})
							in_transaction_set_filter(:after_create, method, options)
						end


						def in_transaction_before_update(method, options = {})
							in_transaction_set_filter(:before_update, method, options)
						end


						def in_transaction_after_update(method, options = {})
							in_transaction_set_filter(:after_update, method, options)
						end


						def in_transaction_before_delete(method, options = {})
							in_transaction_set_filter(:before_delete, method, options)
						end


						def in_transaction_after_delete(method, options = {})
							in_transaction_set_filter(:after_delete, method, options)
						end


						def in_transaction_before_purge(method, options = {})
							in_transaction_set_filter(:before_purge, method, options)
						end


						def in_transaction_after_purge(method, options = {})
							in_transaction_set_filter(:after_purge, method, options)
						end


						def in_transaction_filters_collection(name)
							if defined?(@in_transaction_filters_collection) == false || @in_transaction_filters_collection.nil? || !@in_transaction_filters_collection.is_a?(Hash)
								@in_transaction_filters_collection = {}
							end
							found_filters = @in_transaction_filters_collection[name]
							unless found_filters && found_filters.is_a?(Array)
								found_filters = []
								@in_transaction_filters_collection[name] = found_filters
							end
							found_filters
						end


						def out_transaction_before_create(method, options = {})
							out_transaction_set_filter(:before_create, method, options)
						end

						def out_transaction_after_create(method, options = {})
							out_transaction_set_filter(:after_create, method, options)
						end


						def out_transaction_before_update(method, options = {})
							out_transaction_set_filter(:before_update, method, options)
						end


						def out_transaction_after_update(method, options = {})
							out_transaction_set_filter(:after_update, method, options)
						end


						def out_transaction_before_delete(method, options = {})
							out_transaction_set_filter(:before_delete, method, options)
						end


						def out_transaction_after_delete(method, options = {})
							out_transaction_set_filter(:after_delete, method, options)
						end


						def out_transaction_before_purge(method, options = {})
							out_transaction_set_filter(:before_purge, method, options)
						end


						def out_transaction_after_purge(method, options = {})
							out_transaction_set_filter(:after_purge, method, options)
						end


						def out_transaction_filters_collection(name)
							if defined?(@out_transaction_filters_collection) == false || @out_transaction_filters_collection.nil? || !@out_transaction_filters_collection.is_a?(Hash)
								@out_transaction_filters_collection = {}
							end
							found_filters = @out_transaction_filters_collection[name]
							unless found_filters && found_filters.is_a?(Array)
								found_filters = []
								@out_transaction_filters_collection[name] = found_filters
							end
							found_filters
						end


						private
						def in_transaction_set_filter(filter_name, method, options)
							raise "#{method} must be a symbol" unless method && method.is_a?(Symbol)
							#raise "Method #{method} not found in class #{self}" unless respond_to?(method)


							options ||= {}
							opts = {}.merge(options)
							opts[:method] = method
							in_transaction_filters_collection(filter_name).push(opts)
						end


						def out_transaction_set_filter(filter_name, method, options)
							raise "#{method} must be a symbol" unless method && method.is_a?(Symbol)
							#raise "Method #{method} not found in class #{self}" unless respond_to?(method)


							options ||= {}
							opts = {}.merge(options)
							opts[:method] = method
							out_transaction_filters_collection(filter_name).push(opts)
						end
					end

				end
			end
		end
	end
end
