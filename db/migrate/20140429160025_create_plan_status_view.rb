class CreatePlanStatusView < ActiveRecord::Migration
  def self.up
    create_view :latest_section_locks, "SELECT ps1.plan_id, ps1.section_id, ps1.created_at AS locked_at, ps1.user_id AS locked_by FROM plan_sections ps1 WHERE ps1.created_at = (SELECT MAX(ps2.created_at) FROM plan_sections ps2 WHERE ps2.plan_id = ps1.plan_id AND ps2.section_id = ps1.section_id)"
  end

  def self.down
    drop_view :latest_section_locks
  end
end
