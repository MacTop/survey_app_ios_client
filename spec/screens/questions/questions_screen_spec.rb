describe "QuestionScreen" do

  before do
    @questions_screen = QuestionScreen.new
    @questions_screen.survey_id = 5
    @questions_screen.on_load
  end

  it "should have a instance of FieldView" do
    sub_views = @questions_screen.view.subviews.collect{|sub_view| sub_view.class}
    sub_views.should.include FieldView
  end

  it "should calculate the origin of the next view" do
    @questions_screen.view.subviews.each{|view| view.removeFromSuperview}
    @questions_screen.get_origin_y(@questions_screen.view).should == 0
    @questions_screen.view.addSubview(UIView.alloc.initWithFrame CGRectMake(100, 100, 200, 200))
    @questions_screen.get_origin_y(@questions_screen.view).should == 300
  end
=begin
  it "should increment current_view by one on swipe left" do
    flick "question_screen", :from => :right, :to => :left
    @questions_screen.instance_variable_get(:@current_page).should == 1
    field_views = @questions_screen.view.subviews.collect{|subview| subview if subview.class == FieldView}
    field_views.last.viewWithTag(100).text.should == @second_arg[:content]
  end
=end

  it "should include header view" do
    sub_views = @questions_screen.view.subviews.collect{|sub_view| sub_view.class.to_s}
    sub_views.should.include "HeaderView"
  end

  it "should return true if the current page is the last page" do
    @questions_screen.instance_variable_set(:@current_page, 2)
    @questions_screen.is_last_page?.should == true
  end

  it "should add a submit button to the parent view" do
    questions = @questions_screen.instance_variable_get(:@questions)
    questions.last.viewWithTag(Tags::SubmitButtonView).should.not.be.nil
  end
end
