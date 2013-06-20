Teacup::Stylesheet.new :main do
  @heading_text_font = UIFont.systemFontOfSize(20)
  @header_background_color = UIColor.colorWithRed(0.027, green: 0.459, blue: 0.557, alpha: 1)
  @description_text_font = UIFont.systemFontOfSize(11)
  @survey_item_text_color = UIColor.colorWithRed(0.027, green: 0.459, blue: 0.557, alpha: 1)
  @survey_item_background_color = UIColor.clearColor
  @expiry_date_text_font = UIFont.systemFontOfSize(14)
  
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
end
