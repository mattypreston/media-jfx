class AddChunksToAssetModel < ActiveRecord::Migration
  def change
    add_column :assets, :expected_chunks, :integer
    add_column :assets, :received_chunks, :integer
  end
end
