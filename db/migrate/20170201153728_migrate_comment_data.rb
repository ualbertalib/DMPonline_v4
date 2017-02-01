class MigrateCommentData < ActiveRecord::Migration
  def change
    Comment.find_each do |a|
      a.text = a.old_text
      a.save
    end
    remove_column :comments, :old_text
  end
end
