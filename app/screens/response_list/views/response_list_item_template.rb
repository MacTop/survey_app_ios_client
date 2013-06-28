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
    self.initWithFrame CGRectMake(MARGIN, 0, MAX_WIDTH, 30)
    self.backgroundColor = UIColor.whiteColor
    subview(set_question_answer_label(args), :response_question_label)
    reset_field_frame 10
    self
  end

  def set_question_answer_label args
    answer = get_newest_answer_first(args)
    question = Question.find(:id => answer.question_id).first
    question_answer_text = "#{question.content}: #{answer.content}"
    question_answer_label = UILabel.alloc.initWithFrame(CGRectMake(MARGIN, 10, MAX_WIDTH - (2*MARGIN), 40))
    set_label_dynamicity question_answer_label, question_answer_text, Tags::ResponseQuestionAnswerLabel
    question_answer_label
  end

  def get_newest_answer_first args
    answers = args[:survey_response].answers.to_a
    answers.sort_by{|answer| answer.created_at}.first
  end
end
