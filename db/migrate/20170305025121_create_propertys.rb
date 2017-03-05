class CreatePropertys < ActiveRecord::Migration
  def change
    create_table :propertys do |t|
      t.string :name
      t.string :type
      t.decimal :value, precision: 18, scale: 2
    end
  end
end
