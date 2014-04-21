class CartsController < ApplicationController
  def index
    @carts = Cart.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @carts }
    end
  end

  def show
  end

  def new
    @cart = Cart.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cart }
    end
  end

  # def edit
  #   @cart = Cart.find(params[:id])
  # end

  # def create
  #   @cart = Cart.new(params[:cart])

  #   respond_to do |format|
  #     if @cart.save
  #       format.html { redirect_to(@cart, notice: 'Cart was successfully created.') }
  #     else
  #       format.html { render action: 'new' }
  #     end
  #   end
  # end

  # def update
  #   @cart = Cart.find(params[:id])

  #   respond_to do |format|
  #     if @cart.update_attributes(params[:cart])
  #       format.html { redirect_to(@cart, :notice => 'Cart was successfully updated.') }
  #       format.xml  { head :ok }
  #     else
  #       format.html { render :action => "edit" }
  #       format.xml  { render :xml => @cart.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end

  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy

    respond_to do |format|
      format.html { redirect_to(products_url) }
      format.xml  { head :ok }
    end
  end
end
