class EncryptAnswerText < ActiveRecord::Migration
  def up
    rename_column :answers, :text, :old_text
    add_column :answers, :encrypted_text, :string
    Answer.find_each do |a|
      a.text = a.old_text
      a.save
    end
    remove_column :answers, :old_text
  end

  def down
  end
end
