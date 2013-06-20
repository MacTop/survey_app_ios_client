=begin
describe "FieldView" do
  before do
    @args = {:type => "SingleLineQuestion", :origin_y => 100, :content => "single_line_question_statement"}
    @delegate = TestDelegate.new
    Question.should.receive(:get_survey).and_return([@args])
    @questions_screen = QuestionScreen.new
    @field_view = FieldView.new(@args)
    @questions_screen.on_load
  end

  it "should set the question statement in the view" do
    field_views = @questions_screen.view.subviews.select{|subview| subview if subview.class == FieldView}
    question_statement_label = field_views.last.viewWithTag(100)
    question_statement_label.text.should == @args[:content]
  end

  it "should get the height of label frame dynamically" do
    field_view = @field_view
    question_statement_label = field_view.viewWithTag(100)
    first_height = question_statement_label.frame.size.height
    @args[:content] = "single_line_question_statement"*50
    @field_view = FieldView.new(@args)
    field_view = @field_view
    question_statement_label = field_view.viewWithTag(100)
    second_height = question_statement_label.frame.size.height
    first_height.should < second_height
  end

  it "should add text field if the question type is SingleLineQuestion" do
    @args[:type] = "SingleLineQuestion"
    @field_view = FieldView.new(@args)
    @field_view.viewWithTag(200).should.not.be.nil
  end

  it "should have delegate container controller" do
    @field_view.viewWithTag(200).delegate.class.should == QuestionScreen
  end
end
=end
