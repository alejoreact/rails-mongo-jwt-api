class ApplicationController < ActionController::API
  private

  def authenticate!
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    @decoded = JsonWebToken.decode(header)
    @current_user = User.find(@decoded[:user_id])
  rescue Mongoid::Errors::DocumentNotFound => e
    render json: { message: 'not found' }, status: 404
  rescue JWT::DecodeError => e
    render json: { errors: e.message }, status: :forbidden
  end
end
