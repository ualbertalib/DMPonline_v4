class CreatePlanOverallStatusView < ActiveRecord::Migration
  def self.up
    create_view :plan_summaries, "SELECT lsl.plan_id, lsl.section_id, lsl.locked_at, lsl.locked_by, la.question_id, la.answered_at, la.answered_by FROM latest_section_locks AS lsl LEFT JOIN latest_answers AS la ON lsl.plan_id = la.plan_id AND lsl.section_id = la.section_id UNION SELECT la.plan_id, la.section_id, lsl.locked_at, lsl.locked_by, la.question_id, la.answered_at, la.answered_by FROM latest_section_locks AS lsl RIGHT JOIN latest_answers AS la ON lsl.plan_id = la.plan_id AND lsl.section_id = la.section_id"
  end

  def self.down
    drop_view :plan_summaries
  end
end
