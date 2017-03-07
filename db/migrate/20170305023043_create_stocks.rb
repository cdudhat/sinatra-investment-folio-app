class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :name
      t.decimal :price, precision: 8, scale: 2
      t.integer :number
      t.decimal :value, precision: 18, scale: 2
      t.integer :user_id
    end
  end
end
