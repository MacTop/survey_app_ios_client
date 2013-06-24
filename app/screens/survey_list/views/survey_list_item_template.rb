class SurveyListItemTemplate < UIView
  attr_accessor :survey_id
  include Helpers

  MAX_WIDTH = 300
  MARGIN = 10
  RESPONSE_NAVIGATION_WIDTH = 50

  def initWithFrame(frame)
    super.tap do
      self.stylesheet = :main
    end
  end


  def initialize(args = {})
    self.initWithFrame CGRectMake(MARGIN,  ControlVariables::QuestionMargin, MAX_WIDTH, 100)
    self.backgroundColor = UIColor.whiteColor
    set_survey_name args[:survey].name
    set_survey_description args[:survey].description
    set_survey_expiry_date args[:survey].expiry_date
    self.survey_id = args[:survey].id
    add_response_navigation_view
  end

  def set_survey_name text
    survey_item_field text, 0, Tags::SurveyNameLabel, :survey_item_heading
  end
  
  def set_survey_description text
    survey_item_field text, 20, Tags::SurveyDescriptionLabel, :survey_item_description
  end
  
  def set_survey_expiry_date text
    text = I18n.t('survey_list_screen.expiry_date', :date => text)
    survey_item_field text, 55, Tags::SurveyExpiryDateLabel, :survey_item_expiry_date
  end

  def survey_item_field text, height, tag, style
    field_label = UILabel.alloc.initWithFrame(CGRectMake(MARGIN, height, frame.size.width-RESPONSE_NAVIGATION_WIDTH, ControlVariables::LabelHeight))
    field_label.text = text
    field_label.setTag tag
    subview(field_label, style)
    self.addSubview(field_label)
  end
  
  def add_response_navigation_view
    response_navigation_label = UILabel.alloc.initWithFrame(CGRectMake(frame.size.width-RESPONSE_NAVIGATION_WIDTH, 0, RESPONSE_NAVIGATION_WIDTH, frame.size.height))
    response_navigation_label.text = "+"
    response_navigation_label.setTag Tags::ResponseNavigationLabel
    subview(response_navigation_label,:response_navigation_label)
    response_navigation_label.userInteractionEnabled = true
    response_navigation_label.on_tap { self.superview.controller.show_questions_screen_for self.survey_id}
    self.addSubview(response_navigation_label)
  end
end
