class ResponseListItemTemplate < UIView
  attr_accessor :response
  include Helpers
  include ResponseHelper
  
  MAX_WIDTH = 300
  MARGIN = 10
  
  def initWithFrame(frame)
    super.tap do
      self.stylesheet = :main
    end
  end

  def initialize(args = {})
    self.response = args[:survey_response]
    self.initWithFrame CGRectMake(MARGIN, 0, MAX_WIDTH, 30)
    self.backgroundColor = UIColor.whiteColor
    subview(set_question_answer_label, :response_question_label)
    reset_field_frame 10
    self
  end

  def set_question_answer_label
    answer = get_newest_answer_first
    question = Question.find(:id => answer.question_id).first
    question_answer_text = "#{question.content}: #{answer.content}"
    question_answer_label = UILabel.alloc.initWithFrame(CGRectMake(MARGIN, 10, MAX_WIDTH - (2*MARGIN), 40))
    question_answer_label.backgroundColor = UIColor.clearColor
    question_answer_label.font = UIFont.systemFontOfSize(12)
    set_label_dynamicity question_answer_label, question_answer_text, Tags::ResponseQuestionAnswerLabel
    question_answer_label
  end

  def get_newest_answer_first
    answers = self.response.answers.to_a
    answers = answers.select{|answer| Question.find(:id => answer.question_id).first.parent_id == 0}
    answers.sort_by{|answer| answer.created_at}.first
    # aggregate_question_answers(self.response).first.first
  end
end
