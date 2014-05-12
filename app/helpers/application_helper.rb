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

  def icon_link_to(text, path, options = {}, icon)
    link_to "#{content_tag :i, nil, class: "fa #{icon}"} #{text}".html_safe, path, options
  end

  def quantity_field_tag(quantity)
    content_tag(:div, nil, :class => 'input-group input-group-sm quantity-helper') do
      concat(
        content_tag(:span, nil, :class => 'input-group-btn') do
          button_tag('-', type: 'button', class: 'btn btn-default quantity_minus')
        end
      )

      concat(text_field_tag :quantity, quantity, class: 'form-control text-center')
      concat(
        content_tag(:span, nil, :class => 'input-group-btn') do
          concat button_tag('+', type: 'button', class: 'btn btn-default quantity_plus')
        end
      )
    end
  end

  def order_status(order)
    labels = { 0 => 'label-default', 1 => 'label-info', 2 => 'label-info', 3 => 'label-success'}
    content_tag(:span, nil, :class => "label #{labels[order[:status]]}") do
      order.status
    end
  end
end
