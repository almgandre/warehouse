# frozen_string_literal: true

class ProductFilter
  include ActiveModel::Model

  attr_accessor :name

  def filter
    result = Product.all
    result = result.where(name: name) unless name.blank?
    result
  end
end
