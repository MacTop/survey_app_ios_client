class FieldView < UIView
  attr_accessor :question_id
  include Helpers
  
  MAX_WIDTH = 300
  
  def initialize(args = {})
    self.initWithFrame CGRectMake(10, args[:origin_y] + ControlVariables::QuestionMargin, MAX_WIDTH, 300)
    self.backgroundColor = UIColor.clearColor
    set_question_statement(args)
    set_error_field
    self.send("handle_#{args[:question].type}")
    self.reset_field_frame
    self.question_id = args[:question].id 
    self.setTag Tags::FieldView
  end

  def set_question_statement(args)
    label_view = UILabel.alloc.initWithFrame(CGRectMake(0, 0, frame.size.width, ControlVariables::LabelHeight))
    set_label_dynamicity label_view, args[:question].content
    label_view.backgroundColor = UIColor.clearColor
    label_view.textColor = UIColor.colorWithRed(0.01, green: 0.2, blue: 0.01, alpha: 1)
    self.addSubview(label_view)
  end
  
  def set_error_field
    origin = get_origin_y self
    error_label = UILabel.alloc.initWithFrame(CGRectMake(0, origin, frame.size.width, 0))
    error_label.text = ""
    error_label.setTag Tags::ErrorFieldViewLabel
    error_label.backgroundColor = UIColor.clearColor
    error_label.textColor = UIColor.redColor
    self.addSubview(error_label)
  end
  
  def set_error_message
    update_error_message(I18n.t('field_view.error'), 40, 25)
  end

  def reset_error_message
    error_label = self.viewWithTag(Tags::ErrorFieldViewLabel)
    update_error_message("", 0, -25) unless error_label.text.blank?
  end

  def update_error_message(text, height, offset)
    error_label = self.viewWithTag(Tags::ErrorFieldViewLabel)
    error_label.text = text
    new_frame = error_label.frame
    new_frame.size.height = height
    error_label.frame = new_frame
    index = self.subviews.indexOfObject(error_label)
    (index+1..self.subviews.count-1).each do |position|
      update_input_field_height position, offset
    end
    reset_field_frame
  end

  def update_input_field_height index, offset
    input_field = self.subviews[index]
    new_frame = input_field.frame
    new_frame.origin.y = new_frame.origin.y+offset
    input_field.frame = new_frame
  end
  
  def reset_field_frame
    total_view_height = get_origin_y self
    new_frame = self.frame
    new_frame.size.height = total_view_height
    self.frame = new_frame
  end

  def handle_SingleLineQuestion
    origin = get_origin_y self
    text_field = UITextField.alloc.initWithFrame(CGRectMake(0, origin + ControlVariables::QuestionMargin, MAX_WIDTH, 30))
    text_field.delegate = QuestionScreen.this_controller
    text_field.backgroundColor = UIColor.whiteColor
    text_field.setTag Tags::FieldViewTextField
    text_field.contentVerticalAlignment = 0
    text_field.setBorderStyle(UITextBorderStyleRoundedRect)
    self.addSubview(text_field)
  end

  def handle_RadioQuestion
    origin = get_origin_y self
    puts question_id
    #data = ['a']
    data = Question.find(:id => question_id).first.radio_options.to_a.collect{|option| option.content}
    new_frame = CGRectMake(0, origin + ControlVariables::QuestionMargin,MAX_WIDTH,  min_count(data) * ControlVariables::TableRowHeightDefault)
    @radio_buttons_controller = RadioButtons.new(data: data, frame: new_frame)
    @radio_buttons_controller.view.frame = new_frame
    QuestionScreen.this_controller.addChildViewController(@radio_buttons_controller)
    self.addSubview(@radio_buttons_controller.view)  
  end

  def min_count(data)
    ControlVariables::RadioButtonsMaxCount < data.count ? ControlVariables::RadioButtonsMaxCount : data.count
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
