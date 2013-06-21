class SurveyListItemView < UIView
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
    survey_name_label = UILabel.alloc.initWithFrame(CGRectMake(MARGIN, 0, frame.size.width-RESPONSE_NAVIGATION_WIDTH, ControlVariables::LabelHeight))
    survey_name_label.text = text
    survey_name_label.setTag Tags::SurveyNameLabel
    subview(survey_name_label,:survey_item_heading)
    self.addSubview(survey_name_label)
  end
  
  def set_survey_description text
    survey_description_label = UILabel.alloc.initWithFrame(CGRectMake(MARGIN, 20, frame.size.width-RESPONSE_NAVIGATION_WIDTH, ControlVariables::LabelHeight))
    survey_description_label.text = text
    survey_description_label.setTag Tags::SurveyDescriptionLabel
    subview(survey_description_label,:survey_item_description)
    self.addSubview(survey_description_label)
    
  end
  
  def set_survey_expiry_date text
    survey_expiry_date_label = UILabel.alloc.initWithFrame(CGRectMake(MARGIN, 55, frame.size.width-RESPONSE_NAVIGATION_WIDTH, ControlVariables::LabelHeight))
    survey_expiry_date_label.text = "Expires on #{text}"
    survey_expiry_date_label.setTag Tags::SurveyExpiryDateLabel
    subview(survey_expiry_date_label,:survey_item_expiry_date)
    self.addSubview(survey_expiry_date_label)
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
