class SurveyListScreen < PM::Screen
  title "Survey"
  include Helpers

  stylesheet :main

  def on_load
    set_attributes self.view, stylename: :base_theme
    add HeaderView.new({:title => I18n.t('survey_list_screen.title')})
    Survey.all.each do |survey|
      origin_y = get_origin_y self.view
      add SurveyListItemView.new({:survey => survey, :origin_y => origin_y})
    end
  end

  def will_appear
     self.navigationController.setNavigationBarHidden(true, animated: false)
  end

  def will_disappear
     self.navigationController.setNavigationBarHidden(false, animated: true)
  end

  def show_questions_screen
    open QuestionScreen.new
  end
  
end
