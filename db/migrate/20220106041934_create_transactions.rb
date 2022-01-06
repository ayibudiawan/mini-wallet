class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions, id: :uuid do |t|
      t.references :wallet, type: :uuid
      t.string :status, :transaction_type
      t.datetime :transaction_at
      t.integer :amount
      t.uuid :reference_id
      t.timestamps
    end
  end
end
