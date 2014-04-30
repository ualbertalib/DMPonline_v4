class CreateAnswerStatusView < ActiveRecord::Migration
  def self.up
    create_view :latest_answers, "SELECT a1.plan_id AS plan_id, q.section_id AS section_id, q.id AS question_id,  a1.created_at AS answered_at, a1.user_id AS answered_by FROM answers a1, questions q WHERE q.id = a1.question_id AND a1.created_at = (SELECT MAX(a2.created_at) FROM answers a2 WHERE a2.plan_id = a1.plan_id AND a2.question_id = a1.question_id)"
  end

  def self.down
    drop_view :latest_answers
  end
end
