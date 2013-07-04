describe "MultiLine" do
  before do
    header_view = HeaderView.new({:title => "My Test Header"})
    @multiline_view = MultiLineField.new({:origin_y => 10, :max_width => 300, :header_view => header_view})
  end

  it "should have a text view" do
    text_views = @multiline_view.subviews.select{|subview| subview.class == UITextView}
    text_views.length.should == 1
  end
end
