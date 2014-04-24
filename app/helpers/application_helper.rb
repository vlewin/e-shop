module ApplicationHelper
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
    # .input-group.input-group-sm
      # span.input-group-btn
        # button.btn.btn-default.quantity_minus type="button"  -
      # = text_field_tag :quantity, 1, class: 'form-control input-qty text-center'
      # span.input-group-btn
        # button.btn.btn-default.quantity_plus type="button"  +
  end
end
