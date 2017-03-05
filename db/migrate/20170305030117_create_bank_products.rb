class CreateBankProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :type
      t.decimal :value, precision: 18, scale: 2
  end
end
