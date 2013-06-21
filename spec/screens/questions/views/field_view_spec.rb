describe "FieldView" do
  before do
    @question = Question.all.first
    @args = {:question => @question, :origin_y => 10}
    @field_view = FieldView.new(@args)
  end

  it "should set the question statement in the view" do
    question_statement_label = @field_view.viewWithTag(Tags::FieldViewLabel)
    question_statement_label.text.should == @question.content
    @field_view.question_id.should == @question.id
  end

  it "should get the height of label frame dynamically" do
    field_view = @field_view
    question_statement_label = field_view.viewWithTag(Tags::FieldViewLabel)
    first_height = question_statement_label.frame.size.height
    @question.content = "single_line_question_statement"*50
    @question.save
    @field_view = FieldView.new(@args)
    field_view = @field_view
    question_statement_label = field_view.viewWithTag(Tags::FieldViewLabel)
    second_height = question_statement_label.frame.size.height
    first_height.should < second_height
  end

  it "should add text field if the question type is SingleLineQuestion" do
    @field_view = FieldView.new(@args)
    @field_view.viewWithTag(Tags::FieldViewTextField).should.not.be.nil
  end

  it "should have delegate container controller" do
    @field_view.viewWithTag(Tags::FieldViewTextField).delegate.class.should == QuestionScreen
  end
end
