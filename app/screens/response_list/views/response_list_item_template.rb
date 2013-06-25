class ResponseListItemTemplate < UIView
  include Helpers

  MAX_WIDTH = 300
  MARGIN = 10
  
  def initWithFrame(frame)
    super.tap do
      self.stylesheet = :main
    end
  end

  def initialize(args = {})
    answer =  args[:survey_response].answers.to_a.sort_by{|answer| answer.created_at}.first
    question = Question.find(:id => answer.question_id).first
    question_answer_text = "#{question.content}: #{answer.content}"
    self.initWithFrame CGRectMake(MARGIN, 0, MAX_WIDTH, 30)
    self.backgroundColor = UIColor.whiteColor
    question_answer_label = UILabel.alloc.initWithFrame(CGRectMake(MARGIN, 10, MAX_WIDTH - (2*MARGIN), 40))
    set_label_dynamicity question_answer_label, question_answer_text, Tags::ResponseQuestionAnswerLabel
    subview(question_answer_label, :response_question_label)
    reset_field_frame 10
    self
  end
end
