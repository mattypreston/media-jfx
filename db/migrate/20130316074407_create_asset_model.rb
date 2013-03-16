class CreateAssetModel < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.integer :package_id
      t.string  :name
      t.string  :asset_file
      t.timestamps
    end
  end
end
