module Api::Authentication
  include ApplicationHelper

  def authenticate_request!
    return not_authorized unless user_id_in_token?
    @current_user = Customer.where("xid::text = ?", auth_token[:xid]).first
    @user_wallet = @current_user.try(:wallet)
    return not_authorized if @current_user.blank?
  rescue JWT::VerificationError, JWT::DecodeError
    not_authorized
  end

  def http_token
    @http_token ||= if request.headers['Authorization'].present?
      request.headers['Authorization'].split(' ').last
    end
  end

  def auth_token
    @auth_token ||= JsonWebToken.decode(http_token)
  end

  def user_id_in_token?
    http_token && auth_token && auth_token[:user_id].to_i
  end

  def not_authorized
    render_json(401, "Not authorized")
  end
end
