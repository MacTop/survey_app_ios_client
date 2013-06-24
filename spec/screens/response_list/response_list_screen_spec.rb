describe "ResponseListScreen" do
  
  before do
    @response_list_screen = ResponseListScreen.new
    @response_list_screen.survey_id = Survey.all.first.id
    @response_list_screen.on_load
  end
  
  it "should have a single instance of HeaderView" do
    header_views = @response_list_screen.view.subviews.select{|sub_view| sub_view.class if sub_view.class == HeaderView}
    header_views.count.should == 1
  end
    
    it "should include a SurveyListItemTemplate" do
      survey_list_item_parents = @response_list_screen.view.subviews.select{|sub_view| sub_view.class if sub_view.class == SurveyListItemTemplate}
      survey_list_item_parents.count.should == 1
      end

    it "should have an instance of TableView" do
      sub_views = @response_list_screen.view.subviews.collect{|sub_view| sub_view.class}
      sub_views.should.include UITableView
    end
    
    it "should have an instance of ResponseListItem in the table cell" do
        table = @response_list_screen.instance_variable_get('@table')
        table.reloadData
        cell_subviews = table.visibleCells.first.contentView.subviews.collect{|sub_view| sub_view.class}
        cell_subviews.should.include ResponseListItemTemplate
    end
end
