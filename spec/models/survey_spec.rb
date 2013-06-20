describe "Survey" do
  # extend Facon::SpecHelpers
  
  it "should parse the json and return the surveys" do
     survey_list = '[{"archived":false,"auth_key":"Migar33937q8dPLqi0lV9w","created_at":"2013-06-13T09:16:14Z","description":"Description goes here","expiry_date":"2013-08-24","finalized":true,"id":5,"name":"SuperSurvey!","organization_id":1,"public":true,"published_on":"2013-06-13","thank_you_message":"Thank you for participating in the survey.","updated_at":"2013-06-13T09:23:54Z"}]'
    Survey.should.receive(:get_survey_list_data).and_return(survey_list)
    surveys = Survey.get_survey_list
    surveys.should.not.be.nil
    surveys.class.should == Array
  end
end
