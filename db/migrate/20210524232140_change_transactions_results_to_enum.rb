class ChangeTransactionsResultsToEnum < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :result_new, :integer

    Transaction.where(result: "failed").update_all result_new: 0
    Transaction.where(result: "refunded").update_all result_new: 1
    Transaction.where(result: "success").update_all result_new: 2

    remove_column :transactions, :result

    rename_column :transactions, :result_new, :result
  end
end
