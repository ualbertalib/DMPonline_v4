class EncryptCommentText < ActiveRecord::Migration
  def up
    rename_column :comments, :text, :old_text
    add_column :comments, :encrypted_text, :string
    add_column :comments, :encrypted_text_iv, :string
    Comment.find_each do |a|
      a.text = a.old_text
      a.save
    end
    remove_column :comments, :old_text
  end

  def down
  end
end

