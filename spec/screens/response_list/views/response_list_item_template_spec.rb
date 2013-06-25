describe "ResponseListItemTemplate" do
  before do
    response = SurveyResponse.new(:survey_id => 1)
    @question = Question.find(:id => 1).first
    @answer = Answer.new(:content => "answer content", :question_id => @question.id, :response_id => response.key)
    response.answers << @answer
    @args = {:survey_response => response}
    @response_list_item_template = ResponseListItemTemplate.new(@args)
  end

  it "should set the response details" do
    question_answer_text = "#{@question.content}: #{@answer.content}"
    question_answer_label = @response_list_item_template.viewWithTag(Tags::ResponseQuestionAnswerLabel)

    question_answer_label.text.should == question_answer_text
  end
end
