class CreateDmptemplateTranslations < ActiveRecord::Migration
  def up
    Dmptemplate.create_translation_table!({title: :string, description: :text}, {migrate_data: true})
  end

  def down
    Dmptempate.drop_translation_table! migrate_data:true
  end
end
