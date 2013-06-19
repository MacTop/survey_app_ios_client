describe "QuestionScreen" do

  before do
    # @delegate = TestDelegate.new
    @first_arg = {:type => "SingleLineQuestion", :origin_y => 100, :content => "first_question"}
    @second_arg = {:type => "SingleLineQuestion", :origin_y => 100, :content => "second_question"}
    Question.should.receive(:get_survey).and_return([@first_arg, @second_arg])
    @questions_screen = QuestionScreen.new
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
end
