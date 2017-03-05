class CreateRetirementFunds < ActiveRecord::Migration
  def change
    create_table :funds do |t|
      t.string :name
      t.string :category
      t.decimal :value, precision: 18, scale: 2
      t.integer :user_id
    end
  end
end
