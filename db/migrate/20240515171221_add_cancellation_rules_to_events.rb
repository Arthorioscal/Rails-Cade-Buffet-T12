class AddCancellationRulesToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :partial_cancellation_days, :integer
    add_column :events, :partial_cancellation_fine, :decimal
    add_column :events, :total_cancellation_days, :integer
    add_column :events, :total_cancellation_fine, :decimal
  end
end
