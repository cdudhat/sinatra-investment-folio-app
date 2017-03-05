class CreateRetirementFunds < ActiveRecord::Migration
  def change
    create_table :funds do |t|
      t.string :name
      t.string :type
      t.decimal :value, precision: 18, scale: 2
    end
  end
end
