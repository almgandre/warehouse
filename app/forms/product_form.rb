# frozen_string_literal: true

class ProductForm
  include ActiveModel::Model

  attr_accessor :id, :name, :category, :price

  validates :name, presence: true, if: :new_record?
  validates :product, :category, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  def initialize(attributes)
    @attributes = attributes
    init_form_attributes
  end

  def persisted?
    product.persisted?
  end

  def create
    return unless valid?

    product.assign_attributes(@attributes)
    product.save
  end

  def update
    product.update!(@attributes) if valid?
  end

  def destroy
    product.destroy
  end

  def product
    @product ||= id.present? ? Product.find(id) : Product.new
  end

  private

  def init_form_attributes
    @attributes.each do |name, value|
      public_send("#{name}=", value)
    end
  end

  def new_record?
    !persisted?
  end
end