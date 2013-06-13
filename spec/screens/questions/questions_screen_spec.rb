describe "QuestionScreen" do
  before do
    @delegate = TestDelegate.new
    @questions_screen = QuestionScreen.new
    @questions_screen.on_load
  end

  it "should have a instance of FieldView" do
    sub_views = @questions_screen.view.subviews.collect{|sub_view| sub_view.class}
    sub_views.should.include FieldView
  end

  it "should calculate the origin of the next view" do
    @questions_screen.view.subviews.each{|view| view.removeFromSuperview}
    @questions_screen.get_origin_y.should == 0
    @questions_screen.view.addSubview(UIView.alloc.initWithFrame CGRectMake(100, 100, 200,200))
    @questions_screen.get_origin_y.should == 300
  end
end
