class AddCustomerAttributes < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :name, :string
    add_column :customers, :xid, :uuid
  end
end
