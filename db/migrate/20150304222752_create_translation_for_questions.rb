class CreateTranslationForQuestions < ActiveRecord::Migration
  def up
   Question.create_translation_table!({text: :string, guidance: :text}, {migrate_data: true})
  end

  def down
   Question.drop_translation_table! migrate_data:true
  end
end
