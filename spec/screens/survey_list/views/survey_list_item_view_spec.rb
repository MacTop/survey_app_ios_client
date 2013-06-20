describe "SurveyListItemView" do
  before do
    @args = {:survey_name => "Test Survey", :description => "This is a test survey", :expiry_date => "2013-06-18", :origin_y => 100 }
    @survey_list_item_view = SurveyListItemView.new(@args)
  end

  it "should set the survey details" do
    survey_name_label = @survey_list_item_view.viewWithTag(300)
    survey_description_label = @survey_list_item_view.viewWithTag(350)
    survey_expiry_date_label = @survey_list_item_view.viewWithTag(400)

    survey_name_label.text.should == @args[:survey_name]
    survey_description_label.text.should == @args[:description]
    survey_expiry_date_label.text.should.include @args[:expiry_date]
  end

  it "should add the response navigation view" do
    @survey_list_item_view.viewWithTag(450).should.not.be.nil
  end

end
