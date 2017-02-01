class MigrateAnswerData < ActiveRecord::Migration
  def change
      Answer.find_each do |a|
      a.text = a.old_text
      a.save
    end
    remove_column :answers, :old_text
  end
end
