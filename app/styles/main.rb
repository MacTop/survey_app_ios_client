Teacup::Stylesheet.new :main do
  @heading_text_font = UIFont.systemFontOfSize(20)
  @header_background_color = UIColor.colorWithRed(0.027, green: 0.459, blue: 0.557, alpha: 1)
  @description_text_font = UIFont.systemFontOfSize(11)
  @survey_item_text_color = UIColor.colorWithRed(0.027, green: 0.459, blue: 0.557, alpha: 1)
  @survey_item_background_color = UIColor.clearColor
  @expiry_date_text_font = UIFont.systemFontOfSize(14)
  @respone_label_font = UIFont.systemFontOfSize(12)
  
  style :base_theme,
    backgroundColor: ControlVariables::ScreenColor

  style :survey_item,
    backgroundColor: @survey_item_background_color,
    textColor: @survey_item_text_color

  
  style :survey_item_heading, extends: :survey_item,
    font: @heading_text_font

  style :survey_item_description, extends: :survey_item,
    font: @description_text_font

  style :survey_item_expiry_date, extends: :survey_item,
    font: @expiry_date_text_font
  
  style :response_navigation_label,
    backgroundColor: @header_background_color,
    textAlignment: NSTextAlignmentCenter,
    textColor: UIColor.whiteColor

  style :back_button,
  backgroundColor: UIColor.colorWithRed(0.007, green: 0.339, blue: 0.437, alpha: 1),
  frame: [[5, 5],[60, 38]],
  font: UIFont.systemFontOfSize(14)

  style :radio_buttons_table
  bounces = false
  scrollEnabled = false
  showsVerticalScrollIndicator = false

  style :response_table,
    backgroundColor: ControlVariables::ScreenColor

  style :response_container_view,
    origin: [8,7],
    size: [284, 86],
    backgroundColor: UIColor.redColor

  style :response_question_label,
    font: @respone_label_font,
    textColor: @survey_item_text_color

  style :complete_response_header,
    font: @respone_label_font,
    textColor: @survey_item_text_color
end
