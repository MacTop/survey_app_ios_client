describe "Answer" do
  it "should validate the answer for type SingleLineQuestion" do
    
    question = Question.find(:id => 1).first
    answer = Answer.new(:question_id => question.id, :response_id => 1, :content => "Answer for question")
    answer.valid?.should.be.true
    question.mandatory = true
    answer.content = ""
    answer.valid?.should.be.false
    answer.content = "has content"
    answer.valid?.should.be.true
  end
end
