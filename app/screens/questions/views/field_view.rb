class FieldView < UIView
  include ControlVariables
  
  def initialize(args = {})
    self.initWithFrame CGRectMake(10, args[:origin_y] + QuestionMargin, 300, 50)
    self.backgroundColor = UIColor.redColor
    set_question_statement(args)
    #self.send('handle_#{args["type"]}')
  end

  def set_question_statement(args)
    frame = self.frame
    label_view = UILabel.alloc.initWithFrame(CGRectMake(frame.origin.x, 5, frame.size.width, frame.size.height/2))
    label_view.setTag 100
    label_view.text = args[:content]
    label_view.numberOfLines = 3
    label_view.backgroundColor = UIColor.clearColor
    self.addSubview(label_view)
  end
  
  def will_apper
    super
  end
end
