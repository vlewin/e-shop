module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def product_image_tag(product, version=:thumbnail, options = { class: 'img-responsive', alt: 'image'})
    if product.image_url
      image_tag product.image_url(version), options
    else
      versions = {
        show:       { width: 250, height: 250 },
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
    content_tag(:div, nil, class: 'input-group input-group-sm quantity-helper') do
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
    labels = { accepted: 'label-default', in_progress: 'label-default', shipped: 'label-primary', completed: 'label-success'}
    icons = { accepted: 'fa-archive', in_progress: 'fa-clock-o', shipped: 'fa-truck', completed: 'fa-check-circle'}
    content_tag(:span, nil, class: "label #{labels[status.to_sym]}") do
      concat(
        content_tag(:i, nil, class: "fa #{icons[status.to_sym]}")
      )

      concat ' ' + status.humanize
    end
  end

  # def order_status_select(order)
  #   form_tag update_status_order_path(order), id: :update_status, method: :put do
  #     content_tag(:div, nil, class: 'btn-group') do
  #       button_tag(order.status.humanize, type: :button, class: 'btn btn-default dropdown-toggle', "data-toggle" => "dropdown") do
  #         order.status.humanize
  #         content_tag(:span, nil, class: 'caret')
  #         content_tag(:ul, nil, class: 'dropdown-menu') do
  #           Order.statuses.except(order.status).keys.each_with_index do |status, index|
  #             content_tag(:li, nil, class: 'dropdown-menu') do
  #               radio_button_tag 'order', 'status', id: "ex1_#{index+1}"
  #             end
  #           end
  #         end
  #       end
  #     end
  #   end
  # end

end
