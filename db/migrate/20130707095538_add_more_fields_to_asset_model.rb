class AddMoreFieldsToAssetModel < ActiveRecord::Migration
  def change
    add_column :assets, :uploaded_over_api, :boolean
    add_column :assets, :directory, :string
  end
end
