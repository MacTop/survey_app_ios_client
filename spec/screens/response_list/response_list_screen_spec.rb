describe "ResponseListScreen" do
  
  before do
    @response_list_screen = ResponseListScreen.new
    @response_list_screen.survey_id = Survey.all.first.id
    response = SurveyResponse.new(:survey_id => @response_list_screen.survey_id, :created_at => Time.now)
    @question = Question.find(:id => 1).first
    @answer = Answer.new(:content => "answer content", :question_id => @question.id, :response_id => response.key)
    response.answers << @answer
    response.save
    @response_list_screen.on_load
  end
  
  it "should have a single instance of HeaderView" do
    header_views = @response_list_screen.view.subviews.select{|sub_view| sub_view.class == HeaderView }
    header_views.count.should == 1
  end
  
  it "should include a SurveyListItemTemplate" do
    survey_list_item_parents = @response_list_screen.view.subviews.select{|sub_view| sub_view.class == SurveyListItemTemplate}
    survey_list_item_parents.count.should == 1
  end

  it "should have an instance of TableView" do
    sub_views = @response_list_screen.view.subviews.collect{|sub_view| sub_view.class}
    sub_views.should.include UITableView
  end
  
  it "should have an instance of ResponseListItem in the table cell" do
    @response_list_screen.load_survey_response_data
    table = @response_list_screen.instance_variable_get('@table')
    cell_subviews = table.visibleCells.collect{|cell_view| cell_view.contentView.subviews}
    
    cell_subviews.flatten.select{|sub_view| sub_view.class == ResponseListItemTemplate}.count.should > 0 
  end

  it "should show empty response data message" do
    SurveyResponse.stub!(:find).and_return([])
    @response_list_screen.load_survey_response_data
    @response_list_screen.instance_variable_get('@data').count.should == 1
    table = @response_list_screen.instance_variable_get('@table')
    table.visibleCells.first.contentView.viewWithTag(Tags::EmptyResponseMessageLabel).text.should == I18n.t('response.empty_message')
  end
  
end
