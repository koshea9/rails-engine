class ChangeInvoicesStatusToEnum < ActiveRecord::Migration[5.2]
  def change
    add_column :invoices, :status_new, :integer

    Invoice.where(status: "shipped").update_all status_new: 0
    Invoice.where(status: "returned").update_all status_new: 1
    Invoice.where(status: "packaged").update_all status_new: 2

    remove_column :invoices, :status

    rename_column :invoices, :status_new, :status
  end
end
