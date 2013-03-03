class CreateSiteModel < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :name
      t.string :address_line_1
      t.string :address_line_2
      t.string :address_line_3
      t.string :post_code
      t.string :county
      t.string :country
      t.timestamps
    end
  end
end
