class AddActiveToBuffetsAndEventTypes < ActiveRecord::Migration[7.1]
  def change
    add_column :buffets, :active, :boolean, default: true
    add_column :events, :active, :boolean, default: true
  end
end
