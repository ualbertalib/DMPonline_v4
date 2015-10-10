class ChangeQuestionTranslationsTextType < ActiveRecord::Migration
  def up
  end

  def change
    change_column :question_translations, :text, :text
  end

  def down
  end
end
