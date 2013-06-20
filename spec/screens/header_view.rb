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

=begin
  it "should show the previous screen on click of back button" do
    navigation_controller = UINavigationController.new
    app_delegate = UIApplication.sharedApplication.delegate
    app_delegate.stub!(:get_navigation_controller).and_return(navigation_controller)
    navigation_controller.should_receive(:popToRootViewControllerAnimated)
    @header_view.back_to_previous_screen
  end
=end
  
end
