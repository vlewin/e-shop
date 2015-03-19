module ViewHelper

  def product_image_tag(product, version=:thumbnail, options = { class: 'img-responsive', alt: 'image'})
    if product.image_url
      image_tag product.image_url(version), options
    else
      versions = {
        show:       { width: 380, height: 380 },
        index:      { width: 250, height: 200 },
        thumbnail:  { width: 50, height: 50 },
      }

      image_tag "http://placehold.it/#{versions[version][:width]}x#{versions[version][:height]}", options
    end
  end

  def icon_link_to(text, path, options = {}, icon)
    link_to "#{content_tag :i, nil, class: "fa #{icon}"} #{text}".html_safe, path, options
  end

  def quantity_field_tag(quantity, options = {})
    content_tag(:span, nil, class: 'input-group input-group-sm quantity-helper pull-left') do
      concat(
        content_tag(:span, nil, class: 'input-group-btn') do
          button_tag('-', type: 'button', class: 'btn btn-default quantity_minus')
        end
      )

      concat(text_field_tag :quantity, quantity, class: 'form-control input-disabled text-center', 'data-max' => options[:max])
      concat(
        content_tag(:span, nil, class: 'input-group-btn') do
          concat button_tag('+', type: 'button', class: 'btn btn-default quantity_plus')
        end
      )
    end
  end

  def order_status(status)
    status = status.to_sym
    labels = {
      accepted: 'label-default',
      in_progress: 'label-default',
      shipped: 'label-primary',
      completed: 'label-success'
    }

    icons = {
      accepted: 'fa-clock-o',
      in_progress: 'fa-archive',
      shipped: 'fa-truck',
      completed: 'fa-check-circle'
    }

    texts = {
      accepted: _('Accepted'),
      in_progress: _('In progress'),
      shipped: _('Shipped'),
      completed: _('Completed')
    }

    content_tag(:span, nil, class: "label #{labels[status]}") do
      concat(
        content_tag(:i, nil, class: "fa #{icons[status]}")
      )

      concat ' ' + texts[status]
    end
  end

  def translation_fields_for(object, attribute, translation)
    html ||= content_tag(:div, nil, class: 'form-group') do
      concat content_tag(:label, translation, class: 'col-sm-2 control-label')
      concat(
        content_tag(:div, nil, class: 'col-xs-12 col-sm-8 col-md-6') do
          text_field_tag "#{object.class.class_name.downcase}[#{attribute}]", object.send(attribute), required: true, class: 'form-control'
        end
      )
    end

    locales = object.class.globalize_locales - [current_locale]
    locales.each do |locale|
      title = "#{translation} %s" % locale.upcase
      globilize_attribute = "#{attribute}_#{locale}"

      html += content_tag(:div, nil, class: 'form-group') do
        concat content_tag(:label, title, class: 'col-sm-2 control-label')
        concat(
          content_tag(:div, nil, class: 'col-xs-12 col-sm-8 col-md-6') do
            text_field_tag "#{object.class.class_name.downcase}[#{globilize_attribute}]", object.send(globilize_attribute), class: 'form-control'
          end
        )
      end
    end

    html.html_safe
  end


  def ransack_search_form_for(url, target=nil, search_columns)
    target ||= "##{controller_name}"
    value = params[:q].try(:[], search_columns) || ''

    search_form_for @search, url: url, method: :get, id: 'search-form', class: 'text-right', data: { target: target }, remote: true do
      search_field_tag "q[#{search_columns}]", value, placeholder: _('Search'), class: 'form-control'
    end
  end

  def table_pagination(items, entry_name=nil, collection_name=nil)
    entry_name ||= _(controller_name.singularize.capitalize)
    collection_name ||= _(controller_name.capitalize)

    html ||= content_tag(:tr) do
      concat(
        content_tag(:td, class: 'thick-line', colspan: '100%') do
          content_tag(:div, class: 'row') do
            concat(
              content_tag(:div, class: 'col-sm-5') do
                page_entries_info items, entry_name: entry_name, collection_name: collection_name
              end
            )

            concat(
              content_tag(:div, class: 'col-sm-7 text-right') do
                paginate items
              end
            )
          end
        end
      )
    end

    html.html_safe
  end

end
