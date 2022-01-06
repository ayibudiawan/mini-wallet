class ApiController < ActionController::API
  attr_reader :current_user
  attr_reader :user_wallet

  include Api::Authentication
  include Api::DryHelper

  respond_to :json

  before_action :authenticate_request!
end
