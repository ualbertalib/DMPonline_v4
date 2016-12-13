class Comment < ActiveRecord::Base

    #associations between tables
    belongs_to :question
    
    #fields
    attr_encrypted :text, key: Figaro.env.dmp_comment_key
    attr_accessible :question_id, :text, :user_id, :archived, :plan_id, :archived_by

    
    
    def to_s
        "#{text}"
    end

end
