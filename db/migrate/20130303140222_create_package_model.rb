class CreatePackageModel < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :name
      t.string :fxml
      t.timestamps
    end
  end
end
