class CreateProjectTranslations < ActiveRecord::Migration
  def up
    Project.create_translation_table!({title: :string, description: :text}, {migration_data: true})
  end

  def down
    Project.drop_translation_table! migration_data:true
  end
end
