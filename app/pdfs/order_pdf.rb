# encoding: utf-8

class OrderPdf < Prawn::Document
  def initialize(order, view)
    super(page_size: 'A4', page_layout: :portrait)

    @order = order
    @view = view

    header
    bounding_box([bounds.left, bounds.top - 170], height: 650, width: 523) do
      text "Invoice No. ##{@order.id}", style: :bold
      items
      total
    end
    footer
  end

  def price(num)
    self.font(Rails.root.join('app/pdfs/fonts/LiberationSans-Regular.ttf'))
    @view.number_to_currency(num)
  end

  def header
    bounding_box([bounds.left, bounds.top], width: 250) do
      text "E-Shop, Inc", size: 12, style: :bold
      move_down 0
      text "Musterstrasse 1
            3000 Musterstadt
            Deutschland", size: 10
    end

    bounding_box([bounds.left, bounds.top-70], width: 250) do
      text @order.billing_address.full_name, size: 12, style: :bold
      move_down 0
      text "#{@order.billing_address.street}
            #{@order.billing_address.zip} #{@order.billing_address.city}", size: 10
    end

    bounding_box([bounds.left + 280, bounds.top], width: 260) do
      move_down 0
      text "Shipping to:", style: :bold
      text "#{@order.address.full_address}", size: 10

      move_down 10
      text "Billing to:", style: :bold
      text "#{@order.address.full_address}", size: 10
    end
  end

  def items
    move_down 15

    table thead do |t|
      t.cell_style = { borders: [], size: 10 }
      t.column_widths = { 0 => 20, 1 => 200, 2 => 100, 3 => 100, 4 => 100 }
      t.columns(0..4).align = :left

      t.before_rendering_page do |p|
        p.row(-1).borders = [:top, :bottom, :left, :right]
      end
    end

    table tbody do |t|
      t.cell_style = { borders: [], size: 10 }
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
    [["Nr", "Product name", "Unit Price", "Quantity", "Full Price"]]
  end

  def tbody
    @order.line_items.each_with_index.map do |item, index|
      [
        index + 1,
        item.product.name,
        price(item.product.price),
        item.quantity,
        price(item.subtotal)
      ]
    end
  end

  def total
    move_down 10

    table total_rows do
      self.cell_style = { borders: [], size: 10, align: :right }
      self.column_widths = { 0 => 323, 1 => 100, 2 => 90 }
      self.header = true
      rows(3).borders = [:top, :bottom]
    end
  end

  def total_rows
    [
      ["", "Sub Total", "#{price(@order.subtotal)}"],
      ["", "Shipping & Handling", "#{price(@order.shipment.fee) rescue 'not calculated'}"],
      ["", "VAT", "#{price(@order.taxes)}"],
      ["", "Total", "#{price(@order.total)}"]
    ]
  end

  def footer
    page_count.times do |i|
      page = i + 1
      go_to_page(page)
      bounding_box([bounds.left+1, bounds.bottom + 10], :width => 500) do
        text "Thank you for your business!", :size => 8
      end
    end
  end
end
