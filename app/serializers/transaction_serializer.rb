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
class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :status, :amount, :reference_id
end
