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

  def product_image_tag(product, version = :thumbnail, options = { class: 'img-responsive', alt: 'image'})
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

  def order_status(order)
    labels = { 0 => 'label-default', 1 => 'label-default', 2 => 'label-primary', 3 => 'label-success'}
    icons = { 0 => 'fa-archive', 1 => 'fa-clock-o', 2 => 'fa-truck', 3 => 'fa-check-circle'}
    content_tag(:span, nil, class: "label #{labels[order[:status]]}") do
      concat(
        content_tag(:i, nil, class: "fa #{icons[order[:status]]}")
      )

      concat ' ' + order.status.humanize
    end
  end
end
