describe "Response View Screen" do
  before do
    @response_view_screen = ResponseView.new
    @survey = Survey.find(:id => 5).first
    @question = @survey.questions.to_a.first
    @answer = Answer.new(:question_id => @question.id, :content => 'asd')
    @response = SurveyResponse.new(:survey_id => @survey.id)
    @response.answers << @answer
    @response.save
    @response_view_screen.survey_response = @response
    @response_view_screen.on_load
  end

  it "shoud have header view" do
    header_views = @response_view_screen.view.subviews.select{|sub_view| sub_view.class == HeaderView }
    header_views.count.should == 1
  end

  it "should have an instance of table view" do
    table_views = @response_view_screen.view.subviews.select{|sub_view| sub_view.class == UITableView}
    table_views.count.should == 1
  end

  it "should have question and corresponding answer in the cell" do
    table = @response_view_screen.instance_variable_get('@table')
    table.reloadData
    cell_subviews = table.visibleCells.collect{|cell_view| cell_view.contentView.subviews}
    labels = cell_subviews.first.first.subviews.select{|sub_view| sub_view.class == UILabel}
    labels.count.should == 3
    labels[1].text.should == @answer.content
    labels[0].text.should == @question.content
  end
end
