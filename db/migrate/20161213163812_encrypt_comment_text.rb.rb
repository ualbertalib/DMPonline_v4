class EncryptCommentText < ActiveRecord::Migration
  def change
    rename_column :comments, :text, :old_text
    add_column :comments, :encrypted_text, :string
    add_column :comments, :encrypted_text_iv, :string
  end
end

