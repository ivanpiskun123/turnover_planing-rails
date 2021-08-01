class AddColumnUserIdToSales < ActiveRecord::Migration[6.1]
  def change
      add_reference :sales, :user, index: true
    end
end
