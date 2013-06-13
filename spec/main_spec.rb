describe "Delegate" do
  before do
    @delegate = TestDelegate.new
  end

  it "open Questions Screen" do
    view('Survey').should.not.be.nil
  end
end
