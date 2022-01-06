class DepositSerializer < TransactionSerializer
  attributes :deposited_by, :deposited_at

  def deposited_by
    object.action_by_id
  end

  def deposited_at
    object.transaction_at
  end
end
