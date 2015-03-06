Kaminari.configure do |config|
  config.default_per_page = 10
  # config.max_per_page = nil
  # config.window = 4
  # config.outer_window = 0
  # config.left = 0
  # config.right = 0
  # config.page_method_name = :page
  # config.param_name = :page
end

module Kaminari
  module ActionViewExtension
    def page_entries_info(collection, options = {})
      entry_name = options[:entry_name] || collection.entry_name
      entry_name = options[:collection_name] || entry_name.pluralize unless collection.total_count == 1

      html = '<span class="page_entries_info">'
      if collection.total_pages < 2
        html += t('helpers.page_entries_info.one_page.display_entries', :entry_name => entry_name, :count => collection.total_count)
      else
        first = collection.offset_value + 1
        last = collection.last_page? ? collection.total_count : collection.offset_value + collection.limit_value
        html += t('helpers.page_entries_info.more_pages.display_entries', :entry_name => entry_name, :first => first, :last => last, :total => collection.total_count)
      end

      html += '</span>'

      raw html
    end
  end
end


# module Kaminari
#   module ActionViewExtension
#     def page_entries_info(collection, options = {})
#       entry_name = options[:entry_name] || collection.entry_name
#       entry_name = options[:collection_name] || entry_name.pluralize unless collection.total_count == 1

#       if collection.total_pages == 1
#         "#{entry_name} #{collection.total_count} of #{collection.total_count}"
#       else
#         first = collection.offset_value + 1
#         last = collection.last_page? ? collection.total_count : collection.offset_value + collection.limit_value

#         "#{entry_name } - #{first}-#{last} of #{collection.total_count}"
#       end
#     end
#   end
# end
