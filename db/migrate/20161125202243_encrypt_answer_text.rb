class EncryptAnswerText < ActiveRecord::Migration
  def change
    rename_column :answers, :text, :old_text
    add_column :answers, :encrypted_text, :string
    add_column :answers, :encrypted_text_iv, :string
  end
end
