describe "Header View" do
  before do
    # @args = {:type => "SingleLineQuestion", :origin_y => 100, :content => "single_line_question_statement"}
    @delegate = TestDelegate.new
    # Question.should.receive(:get_survey).and_return([@args])
    @questions_screen = QuestionScreen.new
    @questions_screen.survey_id = 5
    @questions_screen.on_load
    @header_views = @questions_screen.view.subviews.select{|view| view if view.class == HeaderView}
  end

  it "should add logo to the header view" do
    @header_views.count.should == 1
    image_views = @header_views.first.subviews.select{|view| view if view.class == UIImageView}
    image_views.first.image.should.not.be.nil
  end

  it "should set title to the header view" do
    label_views = @header_views.first.subviews.select{|view| view if view.class == UILabel}
    label_views.should.not.be.empty
    label_views.first.text.should.not.be.nil
  end
end
