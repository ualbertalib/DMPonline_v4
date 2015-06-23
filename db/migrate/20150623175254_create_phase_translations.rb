class CreatePhaseTranslations < ActiveRecord::Migration
  def up
    Phase.create_translation_table!({title: :string, description: :text}, {migrate_data: true})
  end

  def down
    Phase.drop_translation_table! migrate_data:true
  end
end
