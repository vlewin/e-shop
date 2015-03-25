# encoding: utf-8
require 'prawn'
require 'prawn/table'

class OrderPdf < Prawn::Document
  def initialize(order, view)
    super(page_size: 'A4', page_layout: :portrait)

    font_families.update(
      'Verdana' => {
        normal:   Rails.root.join('app/pdfs/fonts/Verdana.ttf'),
        bold:     Rails.root.join('app/pdfs/fonts/Verdana-Bold.ttf'),
        italic:   Rails.root.join('app/pdfs/fonts/Verdana-Italic.ttf')
      }
    )

    font "Verdana", size: 10, :leading => 500

    @order = order
    @view = view

    header
    bounding_box([bounds.left, bounds.top - 170], height: 650, width: 523) do
      text _("Order #%d") % @order.id, style: :bold
      items
      total
    end
    footer
  end

  def price(num)
    @view.number_to_currency(num)
  end

  def header
    bounding_box([bounds.left, bounds.top], width: 250) do
      text "E-Shop GmbH", style: :bold, leading: 5
      text "Musterstrasse 1"
      text "3000 Musterstadt"
      text "Tel: (0123) 456789"
    end

    bounding_box([bounds.left + 360, bounds.top], width: 260) do
      if @order.billing_address == @order.shipping_address
        text _('Shipping and Billing address'), style: :bold, :leading => 5
        text @order.billing_address.recipient
        text @order.billing_address.street
        text "#{@order.billing_address.zip_code} #{@order.billing_address.city}"

      else
        text _('Billing address'), style: :bold, :leading => 5
        text @order.billing_address.recipient
        text @order.billing_address.street
        text "#{@order.billing_address.zip_code} #{@order.billing_address.city}"

        move_down 20

        text _('Shipping address'), style: :bold, :leading => 5
        text @order.shipping_address.recipient
        text @order.shipping_address.street
        text "#{@order.shipping_address.zip_code} #{@order.shipping_address.city}"
      end
    end
  end

  def items
    move_down 15

    table thead do |t|
      t.cell_style = { borders: [] }
      t.column_widths = { 0 => 20, 1 => 200, 2 => 100, 3 => 100, 4 => 100 }
      t.columns(0..4).align = :left

      t.before_rendering_page do |p|
        p.row(-1).borders = [:top, :bottom, :left, :right]
      end
    end

    table tbody do |t|
      t.cell_style = { borders: [] }
      t.column_widths = { 0 => 20, 1 => 200, 2 => 100, 3 => 100, 4 => 100 }
      t.row_colors = ["FAFAFA", "FFFFFF"]
      t.columns(0..4).align = :left

      t.before_rendering_page do |p|
        p.columns(0..4).borders = [:left, :right]
        p.row(-1).borders = [:bottom, :left, :right]
      end
    end
  end

  def thead
    [['#', _('Title'), _('Quantity'), _('Price'), _('Total')]]
  end

  def tbody
    @order.line_items.each_with_index.map do |item, index|
      [
        index + 1,
        item.product.title,
        item.quantity,
        price(item.product.price),
        price(item.price)
      ]
    end
  end

  def total
    move_down 10

    table total_rows do
      self.cell_style = { borders: [], size: 10, align: :right }
      self.column_widths = { 0 => 260, 1 => 162, 2 => 100 }
      self.header = true
      rows(3).borders = [:top]
    end
  end

  def total_rows
    [
      ['', _('Subtotal'), "#{price(@order.subtotal)}"],
      ['', _('Shipment'), "#{price(@order.shipment.fee) rescue 'not calculated'}"],
      ['', _('incl. VAT'), "#{price(@order.taxes)}"],
      ['', _('Total'), "#{price(@order.total)}"]
    ]
  end

  def footer
    page_count.times do |i|
      page = i + 1
      go_to_page(page)
      bounding_box([bounds.left+1, bounds.bottom + 10], width: 500) do
        text _('Thank you for your business!'), size: 8
      end
    end
  end
end
