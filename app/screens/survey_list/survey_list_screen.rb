class SurveyListScreen < PM::Screen
  title "Survey"
  include Helpers

  stylesheet :main

  def on_load
    set_attributes self.view, stylename: :base_theme
    add HeaderView.new({:title => I18n.t('survey_list_screen.title')})
    Survey.get_survey_list.each_with_index do |survey, index|
      origin_y = get_origin_y self.view
      args = {:survey_name => survey[:name], :description => survey[:description], :expiry_date => survey[:expiry_date], :origin_y => origin_y}
      add SurveyListItemView.new(args)
    end
  end

  def show_alert
    open QuestionScreen.new
  end

  def will_appear
     self.navigationController.setNavigationBarHidden(true, animated: false)
  end

  def will_disappear
     self.navigationController.setNavigationBarHidden(false, animated: true)
  end

  
end
