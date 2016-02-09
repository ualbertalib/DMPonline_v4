class CreateSectionTranslations < ActiveRecord::Migration
  def up
    Section.create_translation_table!({title: :string, description: :text}, {migrate_data: true})
  end

  def down
    Section.drop_translation_table! migrate_data: true
  end
end
