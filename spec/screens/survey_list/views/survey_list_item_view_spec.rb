describe "SurveyListItemView" do
  before do
    @args = {:survey => Survey.all.first, :origin_y => 10}
    @survey_list_item_view = SurveyListItemView.new(@args)
  end

  it "should set the survey details" do
    survey_name_label = @survey_list_item_view.viewWithTag(Tags::SurveyNameLabel)
    survey_description_label = @survey_list_item_view.viewWithTag(Tags::SurveyDescriptionLabel)
    survey_expiry_date_label = @survey_list_item_view.viewWithTag(Tags::SurveyExpiryDateLabel)
    
    survey_name_label.text.should == @args[:survey].name
    survey_description_label.text.should == @args[:survey].description
    survey_expiry_date_label.text.should.include @args[:survey].expiry_date
  end

  it "should add the response navigation view" do
    @survey_list_item_view.viewWithTag(Tags::ResponseNavigationLabel).should.not.be.nil
  end

  describe "response count" do
    before do
      @args = {:survey => Survey.all.first, :origin_y => 10}
      @args[:survey].survey_responses.to_a.each do |response|
        @args[:survey].survey_responses.delete(response)
      end
      @expected_count = 3
      @expected_count.times do
        @args[:survey].survey_responses << SurveyResponse.new(:survey_id => @args[:survey].id, :created_at => Time.now)
      end
      @args[:survey].save
      @survey_list_item_view = SurveyListItemView.new(@args)
    end
    
    it "should show the survey response count" do
      @survey_list_item_view.viewWithTag(Tags::SurveyResponseCountLabel).text.should.include @expected_count.to_s
    end
  end
end
