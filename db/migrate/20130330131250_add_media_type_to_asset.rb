class AddMediaTypeToAsset < ActiveRecord::Migration
  def change
    add_column :assets, :media_type, :string, :limit => 4
    end
end
