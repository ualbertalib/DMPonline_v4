class CreateQuestionFormatTranslations < ActiveRecord::Migration
  def up
    QuestionFormat.create_translation_table!({title: :string, description: :text}, {migrate_data: true} )
  end

  def down
    QuestionFormat.drop_translation_table! migrate_data:true
  end
end
