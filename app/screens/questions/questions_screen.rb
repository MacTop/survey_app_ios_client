class QuestionScreen < PM::Screen
  include Helpers
  include Constants

  SwipeToChange = "Swipe to turn pages"
  
  def on_load
    @@this_controller = self
    set_attributes self.view, {
      backgroundColor: ControlVariables::ScreenColor
    }
    self.view.addSubview(HeaderView.new({:title => "New Response"}))
    self.view.accessibilityLabel = "question_screen"
    @questions = []
    @current_page = 0
    Question.get_survey.each_with_index do |question, index|
      question[:content] = "#{index+1}. #{question[:content]}"
      question[:origin_y] = get_origin_y self.view
      @questions << FieldView.new(question)
    end
    self.view.addSubview(@questions[0])
    add_swipe_view
    swipe_left_handler
    swipe_right_handler
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
    
    self.view.on_swipe(direction: :left, fingers: 1) do
      if @current_page < @questions.count-1
        @current_page += 1
        self.addQuestionView(ControlVariables::ScreenWidth)
      end
    end
  end

  def swipe_right_handler
    self.view.on_swipe(direction: :right, fingers: 1) do
      unless @current_page.zero?
        @current_page -= 1
        self.addQuestionView(-ControlVariables::ScreenWidth)
      end
    end
  end
  
  def self.this_controller
    @@this_controller
  end

end
