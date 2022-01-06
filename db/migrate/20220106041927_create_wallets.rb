class CreateWallets < ActiveRecord::Migration[6.0]
  def change
    create_table :wallets, id: :uuid do |t|
      t.references :customer, type: :uuid
      t.string :status
      t.datetime :enabled_at, :disabled_at
      t.integer :balance
      t.timestamps
    end
  end
end
