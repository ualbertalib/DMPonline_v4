class CreateGuidanceTranslations < ActiveRecord::Migration
  def up
    Guidance.create_translation_table!({text: :text}, {migrate_data: true})
  end

  def down
    Guidance.drop_translation_table! migrate_data:true
  end
end
