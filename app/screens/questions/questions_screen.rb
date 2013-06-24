class QuestionScreen < PM::Screen
  attr_accessor :survey_id
  attr_accessor :first_field_view_with_error
  include Helpers
  stylesheet :main

  SwipeToChange = I18n.t('question_screen.swipe_to_change')
  
  def on_load
    @@this_controller = self
    set_attributes self.view, stylename: :base_theme
    self.view.addSubview(HeaderView.new({:title => I18n.t('question_screen.title')}))
    self.view.accessibilityLabel = I18n.t('question_screen.accessibility_label')
    @questions = []
    @current_page = 0
    populate_questions
    self.view.addSubview(@questions[0])
    add_swipe_view
    add_swipe_bindings
    add_submit_button unless @questions.empty?
  end

  def add_swipe_bindings
    self.view.on_swipe(direction: :left, fingers: 1){self.swipe_left_handler}
    self.view.on_swipe(direction: :right, fingers: 1){self.swipe_right_handler}
  end

  def populate_questions
    Question.find(:survey_id => self.survey_id).each_with_index do |question, index|
      question.content = "#{index+1}. #{question.content}"
      question.content = "#{question.content} *" if question.mandatory
      field_view = FieldView.new({:question => question, :origin_y => get_origin_y(self.view) })
      @questions << field_view
    end
  end
  
  def will_appear
    self.navigationController.setNavigationBarHidden(true, animated: false)
  end

  def will_disappear
    self.navigationController.setNavigationBarHidden(false, animated: true)
  end
  
  def textFieldDidBeginEditing(textField)
  end

  def textFieldDidEndEditing(textField)
  end

  def add_swipe_view
    @page_label_view = UILabel.alloc.initWithFrame(CGRectMake(0, self.view.frame.size.height-ControlVariables::SwipeBannerHeight, self.view.frame.size.width, ControlVariables::SwipeBannerHeight))
    @page_label_view.textAlignment = NSTextAlignmentCenter
    @page_label_view.textColor = UIColor.whiteColor
    @page_label_view.backgroundColor = UIColor.colorWithRed(0.5, green:0.5, blue:0.5, alpha:1)
    update_page_number
    self.view.addSubview(@page_label_view)
  end

  def update_page_number
    @page_label_view.text = "<<  #{SwipeToChange} - #{@current_page+1 }/#{@questions.count}  >>"
  end

  def addQuestionView(offset)
    update_page_number
    UIView.animateWithDuration(0.5 ,animations: self.first_animation(offset) , completion: self.get_completion)
    next_view = @questions[@current_page]
    next_view_frame = next_view.frame
    next_view_frame.origin.x = offset
    next_view.frame = next_view_frame
    self.view.addSubview(next_view)
    UIView.animateWithDuration(0.5, animations: self.second_animation)
  end

  def first_animation(offset)
    Proc.new do
      first_view = self.view.viewWithTag(Tags::FieldView)
      frame = first_view.frame
      frame.origin.x = -1*offset
      self.view.viewWithTag(Tags::FieldView).frame = frame   
    end
  end

  def get_completion
    lambda{|finished| self.view.viewWithTag(Tags::FieldView).removeFromSuperview}
  end

  def second_animation
    Proc.new do
      last_view = self.view.subviews.last
      frame = last_view.frame
      frame.origin.x = 10
      self.view.subviews.last.frame = frame
    end
  end

  def swipe_left_handler
    if @current_page < @questions.count-1
      @current_page += 1
      self.addQuestionView(ControlVariables::ScreenWidth)
    end
  end

  def swipe_right_handler
    unless @current_page.zero?
      @current_page -= 1
      self.addQuestionView(-ControlVariables::ScreenWidth)
    end
  end
  
  def is_last_page?
    @current_page == @questions.count-1
  end

  def add_submit_button
    button_width = ControlVariables::SubmitButtonWidth
    button_height = ControlVariables::SubmitButtonHeight
    view_size = @questions.last.frame.size
    origin  = view_size.height + ControlVariables::QuestionMargin
    submit_button = UIButton.buttonWithType(UIButtonTypeCustom)
    submit_button.frame = CGRectMake(view_size.width/2 - button_width/2 , origin, button_width, button_height)
    submit_button.setTag(Tags::SubmitButtonView)
    submit_button.setTitle("Complete", forState: UIControlStateNormal)
    submit_button.backgroundColor = UIColor.colorWithRed(0.027, green: 0.459, blue: 0.557, alpha: 1)
    @questions.last.addSubview(submit_button)
    @questions.last.reset_field_frame
    submit_button.when(UIControlEventTouchUpInside) do
      save_response
    end
  end

  def save_response
    survey_response = SurveyResponse.new(:survey_id => self.survey_id)
    survey = Survey.find(:id => self.survey_id).first
    self.first_field_view_with_error = nil
    if valid_anwsers? survey_response
      survey_response.save
      survey.survey_responses << survey_response
      survey.save
      self.navigation_controller.popToRootViewControllerAnimated(true) 
      UIAlertView.alert(I18n.t('response.success'))
    else
      show_first_error_view
    end
  end

  def valid_anwsers? survey_response
    is_valid = true
    @questions.each do |field_view|
      question_id = field_view.question_id
      answer_content = field_view.viewWithTag(Tags::FieldViewTextField).text
      answer = Answer.new(:question_id => question_id, :response_id => survey_response.key, :content => answer_content)
      field_view.reset_error_message if answer.valid?
      set_error_field field_view unless answer.valid?
      is_valid = false unless is_valid && answer.valid?
      survey_response.answers << answer
    end
    is_valid
  end

  def show_first_error_view
    error_page = @questions.indexOfObject(self.first_field_view_with_error)
    if @current_page != error_page
      @current_page = error_page
      self.addQuestionView(-ControlVariables::ScreenWidth)
    end
  end

  def set_error_field field_view
    self.first_field_view_with_error = field_view if self.first_field_view_with_error.nil?
    error_label = field_view.viewWithTag(Tags::ErrorFieldViewLabel)
    field_view.set_error_message if error_label.text.blank?
  end
  
  def self.this_controller
    @@this_controller
  end
end
