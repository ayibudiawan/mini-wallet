class WithdrawalSerializer < TransactionSerializer
  attributes :withdrawn_by, :withdrawn_at

  def withdrawn_by
    object.action_by_id
  end

  def withdrawn_at
    object.transaction_at
  end
end
