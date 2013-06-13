describe "Question" do
  extend Facon::SpecHelpers
  it "should parse the json and return the questions" do
    survey_string = '[{"category_id":null,"content":"Single Line Question","created_at":"2013-06-13T09:19:26Z","finalized":true,"id":22,"identifier":true,"image":{"url":null,"thumb":{"url":null},"medium":{"url":null}},"mandatory":true,"max_length":null,"max_value":null,"min_value":null,"order_number":0,"parent_id":null,"photo_file_size":null,"photo_secure_token":null,"private":false,"survey_id":5,"updated_at":"2013-06-13T09:23:24Z","type":"SingleLineQuestion","image_url":null}]'
    Question.should.receive(:get_survey_data).and_return(survey_string)
    questions = Question.get_survey
    questions.should.not.be.nil
    questions.class.should == Array
  end
end
