# == Schema Information
#
# Table name: transactions
#
#  id               :uuid             not null, primary key
#  amount           :integer
#  status           :string
#  transaction_at   :datetime
#  transaction_type :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  action_by_id     :uuid
#  reference_id     :uuid
#  wallet_id        :uuid
#
# Indexes
#
#  index_transactions_on_action_by_id  (action_by_id)
#  index_transactions_on_wallet_id     (wallet_id)
#
class Transaction < ApplicationRecord
  TRANSACTION_TYPE = ["withdrawal", "deposit"]
  TRANSACTION_TYPE.each do |method|
    define_method "is_#{method}?" do
      transaction_type.eql?(method)
    end
    scope method, -> { where(transaction_type: method) }
  end

  STATUS = ["success", "failed"]
  STATUS.each do |method|
    define_method "is_#{method}?" do
      status.eql?(method)
    end
    scope method, -> { where(status: method) }
  end

  belongs_to :action_by, class_name: "Customer", optional: true
  belongs_to :wallet

  validates_inclusion_of :transaction_type, in: TRANSACTION_TYPE
  validates_inclusion_of :status, in: STATUS
  validates_uniqueness_of :reference_id, scope: :transaction_type
  validates :amount, numericality: { greater_than: 0 }
  validate :check_balance

  before_validation :set_status
  before_save :set_transaction_at
  after_save :update_balance

  def check_balance
    current_balance = wallet.balance || 0
    errors.add(:base, "insufficient balance") if current_balance < amount && transaction_type == "withdrawal"
  end

  def set_status
    self.status = "success"
  end

  def set_transaction_at
    self.transaction_at = Time.zone.now
  end

  def update_balance
    current_balance = wallet.balance || 0
    operand = self.is_deposit? ? "+" : "-"
    updated_balance = current_balance.send(operand, self.amount)
    updated_balance = 0 if updated_balance < 0
    wallet.update_column(:balance, updated_balance)
  end
end
