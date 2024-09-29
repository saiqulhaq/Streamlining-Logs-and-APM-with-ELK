class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :request_id
      t.integer :price_cents
      t.string :price_currency

      t.timestamps
    end
  end
end
