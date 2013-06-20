describe "Survey List Screen" do
  before do
    @survey_list_screen = SurveyListScreen.new
    @survey_list_screen.on_load
  end
  
  it "should include header view" do
    sub_views = @survey_list_screen.view.subviews.collect{|sub_view| sub_view.class.to_s}
    sub_views.should.include "HeaderView"
  end

  it "should have a instance of SurveyListItemView" do
    sub_views = @survey_list_screen.view.subviews.collect{|sub_view| sub_view.class}
    sub_views.should.include SurveyListItemView
  end
end
