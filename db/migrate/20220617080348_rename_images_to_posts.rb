class RenameImagesToPosts < ActiveRecord::Migration[7.0]
  def change
    rename_column :posts, :images, :image
  end
end
