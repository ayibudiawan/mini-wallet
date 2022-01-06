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
class WalletSerializer < ActiveModel::Serializer
  attributes :id, :owned_by, :status, :balance

  def owned_by
    object.customer_id
  end
end
