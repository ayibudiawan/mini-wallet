# == Schema Information
#
# Table name: wallets
#
#  id          :uuid             not null, primary key
#  balance     :integer
#  disabled_at :datetime
#  enabled_at  :datetime
#  status      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  customer_id :uuid
#
# Indexes
#
#  index_wallets_on_customer_id  (customer_id)
#
class Wallet < ApplicationRecord
  STATUS = ["enabled", "disabled"]
  STATUS.each do |method|
    define_method "is_#{method}?" do
      status.eql?(method)
    end
    scope method, -> { where(status: method) }
  end

  belongs_to :customer

  has_many :transactions, dependent: :destroy
  has_many :deposits, -> { where(transaction_type: "deposit") }, class_name: "Transaction", foreign_key: "wallet_id"
  has_many :withdrawals, -> { where(transaction_type: "withdrawal") }, class_name: "Transaction", foreign_key: "wallet_id"

  validates_inclusion_of :status, in: STATUS

  before_validation :set_default_attributes
  before_save :set_datetime

  def set_default_attributes
    self.status = "disabled" if new_record? && status.blank?
    self.balance = 0 if new_record? && balance.blank?
  end

  def set_datetime
    if status_changed? && !new_record?
      set_to_null = status == "enabled" ? "disabled_at" : "enabled_at"
      self.send("#{set_to_null}=", nil)
      self.send("#{status}_at=", Time.zone.now)
    end
  end
end
