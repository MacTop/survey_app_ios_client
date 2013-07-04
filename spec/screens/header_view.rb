describe "Header View" do
  
  before do
    @header_view = HeaderView.new({:title => "Header View"})
  end

  it "should add logo to the header view" do
    image_views = @header_view.subviews.select{|view| view if view.class == UIImageView}
    image_views.first.image.should.not.be.nil
  end

  it "should set title to the header view" do
    label_views = @header_view.subviews.select{|view| view if view.class == UILabel}
    label_views.should.not.be.empty
    label_views.first.text.should.not.be.nil
  end

  it "should show the back button if the navigation stack has more than one item" do
    @header_view.stub!(:back_button_needed?).and_return(true)
    @header_view.add_back_button_if_needed
    back_button = @header_view.subviews.select{|view| view if view.class == UIButton}
    back_button.should.not.be.empty
  end

  it "should show the previous screen on click of back button" do
    navigation_controller = mock("navigation controller" )
    
    app_delegate = UIApplication.sharedApplication.delegate
    app_delegate.stub!(:get_navigation_controller).and_return(navigation_controller)
    navigation_controller.stub!(:popViewControllerAnimated)
    navigation_controller.should.receive(:popViewControllerAnimated)
    @header_view.back_to_previous_screen
  end

  it "add a button with text done to its view" do
    view = UIView.alloc.initWithFrame([[200,0],[44,44]])
    @header_view.add_done_button view
    buttons = @header_view.subviews.select{|view| view.class == UIButton}
    buttons.count.should == 2
    buttons.last.titleForState(UIControlStateNormal).should == "Done"
  end
  
end
