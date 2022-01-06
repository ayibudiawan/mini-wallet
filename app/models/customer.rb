# == Schema Information
#
# Table name: customers
#
#  id                     :uuid             not null, primary key
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  xid                    :uuid
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_customers_on_email                 (email) UNIQUE
#  index_customers_on_reset_password_token  (reset_password_token) UNIQUE
#
class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable, :trackable

  has_one :wallet, dependent: :destroy

  has_many :transactions, through: :wallet
  has_many :deposits, through: :wallet
  has_many :withdrawals, through: :wallet

  before_validation :set_xid

  validates_uniqueness_of :xid
  validates_presence_of :wallet, :name

  def set_xid
    loop do
      uuid = SecureRandom.uuid
      self.xid = uuid
      find_by_uuid = Customer.where("xid = ?", uuid)
      break if find_by_uuid.blank?
    end
  end

  def encode
    JsonWebToken.encode({ user_id: id, xid: self.xid, iat: Time.now.to_i, exp: (Time.now + 1.weeks).to_i })
  end
end
