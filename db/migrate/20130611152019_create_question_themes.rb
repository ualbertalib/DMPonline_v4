class CreateQuestionThemes < ActiveRecord::Migration
  def change
    create_table :question_themes do |t|
      t.integer :question_id
      t.integer :theme_id

      t.timestamps
    end
  end
end
