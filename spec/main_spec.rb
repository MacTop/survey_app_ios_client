describe "Delegate" do
  before do
    @delegate = TestDelegate.new
    @app = UIApplication.sharedApplication
  end

  it "should have Questions Screen in navigations controller" do
   window = @app.keyWindow
   root_view_controller = window.rootViewController
   root_view_controller.viewControllers.last.class.should == QuestionScreen
  end
end
