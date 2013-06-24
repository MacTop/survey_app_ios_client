class SurveyListItemView < SurveyListItemTemplate
  def initialize(args = {})
    super
    add_response_list_navigation
  end

  def add_response_list_navigation
    self.on_tap { self.superview.controller.show_responses_screen_for self.survey_id}
  end
end
