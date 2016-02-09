class CreateVersionTranslations < ActiveRecord::Migration
  def up
    Version.create_translation_table!({title: :string, description: :text}, {migrate_data: true})
  end

  def down
    Version.drop_translation_table! migrate_data:true
  end
end
