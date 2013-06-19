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
end
