# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      handle_exception(e.message, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      handle_exception(e.message, :unprocessable_entity)
    end
  end

  private

  def handle_exception(message, http_status_code)
    render json: { message: message }, status: http_status_code
  end
end