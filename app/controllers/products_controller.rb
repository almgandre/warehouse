# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :init_form

  def index
    render json: ProductFilter.new(product_params).filter,
           each_serializer: ProductSerializer,
           status: :ok
  end

  def show
    json_response(product)
  end

  def create
    if @form.valid?
      @form.create
      json_response(@form.product, :created)
    else
      raise_error
    end
  end

  def update
    if @form.valid?
      @form.update
      json_response(@form.product)
    else
      raise_error
    end
  end

  def destroy
    @form.destroy
    head :no_content
  end

  private

  def init_form
    @form = ProductForm.new(product_params)
  end

  def product
    @product ||= Product.find(params[:id])
  end

  def product_params
    params.permit(:name, :category, :price, :id)
  end

  def json_response(object, status = :ok)
    render json: object,
           serializer: ProductSerializer,
           status: status
  end

  def raise_error
    raise ActiveRecord::RecordInvalid.new, @form.errors.messages
  end
end
