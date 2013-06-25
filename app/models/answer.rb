class Answer < NanoStore::Model
  attribute :question_id
  attribute :response_id
  attribute :content
  attribute :created_at
  
  def valid?
    question = Question.find(:id => self.question_id).first
    return true unless question.mandatory
    return false if question.mandatory && self.content.blank?
    true
  end
end
