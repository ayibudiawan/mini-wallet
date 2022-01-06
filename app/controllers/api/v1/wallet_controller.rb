class Api::V1::WalletController < ApiController
  before_action :wallet_exist
  before_action :check_wallet, only: [:index, :deposits, :withdrawals]
  before_action :check_parameters, only: [:deposits, :withdrawals]
  before_action :transactions, only: [:deposits, :withdrawals]

  def index
    render json: { status: "success", data: { wallet: EnabledWalletSerializer.new(user_wallet) } }, status: 200
  end

  def create
    if user_wallet.is_disabled?
      user_wallet.update_attributes(status: "enabled")
      render json: { status: "success", data: { wallet: EnabledWalletSerializer.new(user_wallet) } }, status: 200
    else
      render_json(422, "Wallet enabled already")
    end
  end

  def update
    if user_wallet.is_enabled?
      user_wallet.update_attributes(status: "disabled")
      render json: { status: "success", data: { wallet: DisabledWalletSerializer.new(user_wallet) } }, status: 200
    else
      render_json(422, "Wallet disabled already")
    end
  end

  def deposits
  end

  def withdrawals
  end

  private
    def wallet_exist
      render_json(422, "Wallet not created yet") if user_wallet.blank?
    end

    def check_wallet
      render_json(422, "Cannot use wallet, please enabled it first") if user_wallet.is_disabled?
    end

    def check_parameters
      errors = []
      errors.push("Params amount is required") if params[:amount].blank?
      errors.push("Params reference_id is required") if params[:reference_id].blank?
      render_json(400, errors.join(" and "), data: errors) if errors.present?
    end

    def transactions
      trx = user_wallet.transactions.new(amount: params[:amount], reference_id: params[:reference_id], transaction_type: params[:action].singularize, action_by_id: current_user.id)
      if trx.save
        render json: { status: "success", data: { "#{params[:action].singularize}": "#{params[:action].singularize.capitalize}Serializer".constantize.new(trx) } }, status: 200
      else
        render_json(400, trx.errors, { data: trx })
      end
    end
end
