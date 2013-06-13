class QuestionScreen < PM::Screen
  title "Survey"
  def will_appear
    super
    set_attributes self.view, {
      backgroundColor: UIColor.whiteColor
    }
  end
end
