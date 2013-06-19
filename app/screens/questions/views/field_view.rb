class FieldView < UIView
  include Helpers
 # include Constants
  
  MAX_WIDTH = 300
  
  def initialize(args = {})
    self.initWithFrame CGRectMake(10, args[:origin_y] + ControlVariables::QuestionMargin, MAX_WIDTH, 300)
    self.backgroundColor = UIColor.clearColor
    set_question_statement(args)
    self.send("handle_#{args[:type]}")
    total_view_height = get_origin_y self
    new_frame = self.frame
    new_frame.size.height = total_view_height
    self.frame = new_frame
    self.setTag Tags::FieldView
  end

  def set_question_statement(args)
    label_view = UILabel.alloc.initWithFrame(CGRectMake(0, 0, frame.size.width, ControlVariables::LabelHeight))
    set_label_dynamicity label_view, args[:content]
    label_view.backgroundColor = UIColor.clearColor
    label_view.textColor = UIColor.colorWithRed(0.01, green: 0.2, blue: 0.01, alpha: 1)
    self.addSubview(label_view)
  end

  def handle_SingleLineQuestion
    origin = get_origin_y self
    text_field = UITextField.alloc.initWithFrame(CGRectMake(0, origin + ControlVariables::QuestionMargin, MAX_WIDTH, 30))
   # text_field.borderStyle = UITextBorderStyleLine
   # text_field.layer.borderWidth = 2
   # text_field.layer.borderColor = UIColor.grayColor.CGColor
    text_field.delegate = QuestionScreen.this_controller
    text_field.backgroundColor = UIColor.whiteColor
    text_field.setTag Tags::FieldViewTextField
    text_field.contentVerticalAlignment = 0
    text_field.setBorderStyle(UITextBorderStyleRoundedRect)
    self.addSubview(text_field)
  end

  def viewDidAppear(animated)
    super
  end

  
  private

  def set_label_dynamicity label_view, text
    new_frame = label_view.frame
    label_view.text = text
    label_view.lineBreakMode = UILineBreakModeWordWrap
    new_frame.size.height = get_label_height text, label_view
    label_view.frame = new_frame
    label_view.setTag Tags::FieldViewLabel
    label_view.numberOfLines = 0
  end
  
  def get_label_height text, label
    max_label_size = CGSizeMake(MAX_WIDTH, Float::INFINITY)
    expected_size = text.sizeWithFont(label.font, constrainedToSize: max_label_size,  lineBreakMode: label.lineBreakMode)
    expected_size.height
  end
end
