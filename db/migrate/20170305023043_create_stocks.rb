class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :name
      t.decimal :price, precision: 8, scale: 2
      t.integer :number
    end
  end
end