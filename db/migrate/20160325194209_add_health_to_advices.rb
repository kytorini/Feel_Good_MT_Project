class AddHealthToAdvices < ActiveRecord::Migration
  def change
    add_column :advices, :health, :integer, default: 0
  end
end
