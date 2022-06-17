class RenameFollowerColumnToRelationships < ActiveRecord::Migration[7.0]
  def change
    rename_column :relationships, :following_id, :follower_id
    rename_column :relationships, :follower_id, :followed_id
  end
end
