class LineItemsController < ApplicationController
  # def index
  #   @line_items = LineItem.all

  #   respond_to do |format|
  #     format.html # index.html.erb
  #     format.xml  { render :xml => @line_items }
  #   end
  # end

  # def show
  #   @line_item = LineItem.find(params[:id])

  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.xml  { render :xml => @line_item }
  #   end
  # end

  # GET /line_items/new
  # GET /line_items/new.xml
  def new
    @line_item = LineItem.new()

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @line_item }
    end
  end

  # # GET /line_items/1/edit
  # def edit
  #   @line_item = LineItem.find(params[:id])
  # end

  # POST /line_items
  # POST /line_items.xml
  def create
    puts "**** #{params.inspect}"
    @cart = current_cart
    @line_item = @cart.add_product(params[:product_id], params[:quantity])

    respond_to do |format|
      if @line_item.save!
        format.html { redirect_to(@line_item.cart, notice: 'Line item was successfully created.') }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # # PUT /line_items/1
  # # PUT /line_items/1.xml
  # def update
  #   @line_item = LineItem.find(params[:id])

  #   respond_to do |format|
  #     if @line_item.update_attributes(params[:line_item])
  #       format.html { redirect_to(@line_item, :notice => 'Line item was successfully updated.') }
  #       format.xml  { head :ok }
  #     else
  #       format.html { render :action => "edit" }
  #       format.xml  { render :xml => @line_item.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /line_items/1
  # DELETE /line_items/1.xml
  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy

    redirect_to_back_or_default line_items_url

    # respond_to do |format|
    #   format.html { redirect_to(line_items_url) }
    #   format.xml  { head :ok }
    # end
  end
end
