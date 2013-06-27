class SurveyListItemView < SurveyListItemTemplate
  include Helpers
  def initialize(args = {})
    super
    self.userInteractionEnabled = true
    add_response_list_navigation
  end

   def add_response_list_navigation
     self.on_tap do
       change_highlight self, {:red => 0.933, :green => 0.933, :blue => 0.933, :alpha => 1}
       self.superview.controller.show_responses_screen_for self.survey_id
     end
  end
end
