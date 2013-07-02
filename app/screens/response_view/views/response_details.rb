class ResponseDetails < UIView
  include Helpers
  
  def initialize(answer)
    self.stylesheet = :main
    self.initWithFrame CGRectMake(0,0,320,100)
    question = Question.find(:id => answer.question_id).first
    subview(get_label(question.content, CGRectMake(10, 10, 300, 30), 18), :question_label)
    origin_y = get_origin_y self
    subview(get_label(answer.content, CGRectMake(10, origin_y , 300, 30), 14), :answer_label)
    origin_y = get_origin_y self
    subview(UILabel.alloc.initWithFrame(CGRectMake(0, origin_y + 10, 320, 3)), :separator_label)
    self.reset_field_frame
  end

  def get_label(content, frame, font_size)
    label = UILabel.alloc.initWithFrame(frame)
    label.text = content
    label.color = UIColor.colorWithRed(0.007, green: 0.339, blue: 0.437, alpha: 1)
    label.font =  UIFont.systemFontOfSize(font_size)
    set_label_dynamicity label, content, Tags::ResponseLabels
    label
  end
end
