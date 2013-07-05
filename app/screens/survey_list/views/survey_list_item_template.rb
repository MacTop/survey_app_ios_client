class SurveyListItemTemplate < UIView
  attr_accessor :survey_id, :response_nav_label
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
    self.survey_id = args[:survey].id
    set_survey_name args[:survey].name
    set_survey_description args[:survey].description
    set_survey_expiry_date args[:survey].expiry_date
    set_survey_response_count
    add_response_navigation_view
  end

  def set_survey_name text
    origin = CGPointMake(MARGIN, 0)
    survey_item_field text, origin, Tags::SurveyNameLabel, :survey_item_heading
  end
  
  def set_survey_description text
    origin = CGPointMake(MARGIN, 20)
    survey_item_field text, origin, Tags::SurveyDescriptionLabel, :survey_item_description
  end
  
  def set_survey_expiry_date text
    text = I18n.t('survey_list_screen.expiry_date', :date => text)
    origin = CGPointMake(MARGIN, 55)
    survey_item_field text, origin, Tags::SurveyExpiryDateLabel, :survey_item_expiry_date
  end
  
  def set_survey_response_count
    origin = CGPointMake(225, 55)
    survey_item_field get_survey_responses_count, origin, Tags::SurveyResponseCountLabel, :survey_response_count
  end
  
  def survey_item_field text, origin, tag, style
    field_label = UILabel.alloc.initWithFrame(CGRectMake(origin.x, origin.y, frame.size.width-RESPONSE_NAVIGATION_WIDTH, ControlVariables::LabelHeight))
    field_label.text = text
    field_label.setTag tag
    subview(field_label, style)
  end
  
  def get_survey_responses_count
    Survey.find(:id => self.survey_id).first.survey_responses.to_a.count.to_s
  end
  
  def add_response_navigation_view
    @response_navigation_label = UILabel.alloc.initWithFrame(CGRectMake(frame.size.width-RESPONSE_NAVIGATION_WIDTH, 0, RESPONSE_NAVIGATION_WIDTH, frame.size.height))
    @response_navigation_label.text = "+"
    @response_navigation_label.setTag Tags::ResponseNavigationLabel
    subview(@response_navigation_label,:response_navigation_label)
    apply_corner_right_radii_to(@response_navigation_label, 2)
    @response_navigation_label.userInteractionEnabled = true
    @response_navigation_label.on_tap do
      color = {:red => 0.027, :green => 0.459, :blue => 0.557, :alpha => 0.5}
      change_highlight @response_navigation_label, color
      self.superview.controller.show_questions_screen_for self.survey_id
    end
  end
end
