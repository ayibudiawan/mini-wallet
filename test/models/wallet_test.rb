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
require 'test_helper'

class WalletTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
