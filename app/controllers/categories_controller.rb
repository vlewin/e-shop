class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  def index
    authorize :categories, :index?

    @items = find_and_paginate(order: 'category_translations.title ASC')
    render(partial: 'categories', layout: false) and return if request.xhr?
  end

  def show
    authorize @category
  end

  def edit
    authorize @category
  end

  def new
    @category = Category.new
    authorize @category
  end

  def create
    @category = Category.new(category_params)
    authorize @category

    if @category.save
      redirect_to categories_path, notice: _('Category was successfully created.')
    else
      render action: 'new'
    end
  end

  def update
    authorize @category

    if @category.update(category_params)
      redirect_to categories_path, notice: _('Category was successfully updated.')
    else
      render action: 'edit'
    end
  end

  def destroy
    authorize @category

    @category.destroy
    redirect_to categories_path, notice: _('Category was successfully destroyed.')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category ||= Category.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def category_params
      params.require(:category).permit(*Category.globalize_attribute_names, :title)
    end
end
