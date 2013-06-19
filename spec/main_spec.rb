describe "Delegate" do
  before do
    @app = UIApplication.sharedApplication
  end

  it "should have SurveyList Screen in navigations controller" do
   window = @app.keyWindow
   root_view_controller = window.rootViewController
   root_view_controller.viewControllers.last.class.should == SurveyListScreen
  end
end
