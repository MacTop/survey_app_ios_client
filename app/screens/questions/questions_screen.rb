class QuestionScreen < PM::Screen
  title "Survey"
  
  def on_load
    set_attributes self.view, {
      backgroundColor: UIColor.whiteColor
    }
    
    Question.get_survey.each do |question|
      question[:origin_y] = get_origin_y
      self.view.addSubview(FieldView.new(question))
    end
  end

  def get_origin_y
    last_sub_view = self.view.subviews.last
    if last_sub_view
      origin_y = last_sub_view.frame.origin.y
      height = last_sub_view.size.height
      origin_y + height
    else
      0
    end
  end
end
