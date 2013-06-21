describe "Survey List Screen" do
  before do
    @survey_list_screen = SurveyListScreen.new
    @survey_list_screen.on_load
  end
  
  it "should include header view" do
    sub_views = @survey_list_screen.view.subviews.collect{|sub_view| sub_view.class.to_s}
    sub_views.should.include "HeaderView"
  end

  it "should have a instance of TableView" do
    sub_views = @survey_list_screen.view.subviews.collect{|sub_view| sub_view.class}
    sub_views.should.include UITableView
  end

  it "should have SurveyListItem in the table cell" do
    table = @survey_list_screen.instance_variable_get('@table')
    table.reloadData
    cell_subviews = table.visibleCells.first.contentView.subviews.collect{|sub_view| sub_view.class}
    cell_subviews.should.include SurveyListItemView
  end

  it "should show the questions screen on tap of response navigation view" do
    @survey_list_screen.should_receive(:open) do |arg|
      arg.class.should == QuestionScreen
    end
    @survey_list_screen.show_questions_screen
  end
end
