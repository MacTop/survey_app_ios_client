describe "FieldView" do
  before do
    @args = {:type => "SingleLineQuestion", :origin_y => "100", :content => "single_line_question_statement"}
    @delegate = TestDelegate.new
    Question.should.receive(:get_survey).and_return([@args])
    @questions_screen = QuestionScreen.new
    @questions_screen.on_load
  end

  it "should set the question statement in the view" do
    field_views = @questions_screen.view.subviews.collect{|subview| subview if subview.class == FieldView}
    question_statement_label = field_views.last.viewWithTag(100)
    question_statement_label.text.should == @args[:content]
  end
end
