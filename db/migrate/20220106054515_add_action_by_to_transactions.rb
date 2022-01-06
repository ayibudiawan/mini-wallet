class AddActionByToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_reference :transactions, :action_by, type: :uuid
  end
end
