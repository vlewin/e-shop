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

  # FIXME: Refactoring
  def product_image_tag(product, version = :standard, options = {})
    if product.image.url
      # if Rails.env.production?
        if version ==:standard
          cl_image_tag product.image, {:width => 250, :height => 250, :crop => :fill}.merge(options)
        else
          cl_image_tag product.image, {:width => 220, :height => 120, :crop => :fill}.merge(options)
        end
      # else
        # image_tag product.image.send(version).url, options
      # end
    else
      if version.nil?
        image_tag "http://placehold.it/#{options[:width]}x#{options[:height]}", options
      else
        if version ==:standard
          image_tag "http://placehold.it/250x250", options
        else
          image_tag "http://placehold.it/220x120", options
        end
      end
    end
  end

  def icon_link_to(text, path, options = {}, icon)
    link_to "#{content_tag :i, nil, class: "fa #{icon}"} #{text}".html_safe, path, options
  end

  def quantity_field_tag(quantity, options = {})
    content_tag(:div, nil, :class => 'input-group input-group-sm quantity-helper') do
      concat(
        content_tag(:span, nil, :class => 'input-group-btn') do
          button_tag('-', type: 'button', class: 'btn btn-default quantity_minus')
        end
      )

      concat(text_field_tag :quantity, quantity, class: 'form-control input-disabled text-center', 'data-max' => options[:max])
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
