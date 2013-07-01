describe "Selection Field" do
  before do
    @radio_button_label1 = UILabel.alloc.initWithFrame(CGRectMake(44, 10, 250, 100))
    @radio_button_label2 = UILabel.alloc.initWithFrame(CGRectMake(44, 10, 250, 100))
    @radio_button_label3 = UILabel.alloc.initWithFrame(CGRectMake(44, 10, 250, 100))
    @radio_button_labels = [@radio_button_label1, @radio_button_label2, @radio_button_label3]
    @radio_button_labels.each_with_index do |label, index|
      label.text = "Radio option#{index}"
    end
    new_frame = CGRectMake(0,ControlVariables::QuestionMargin, 300 ,200)
    @selections = SelectionField.new(data: @radio_button_labels, frame: new_frame)
    @selections.viewDidLoad
  end
  
  it "should have a instance of TableView" do
    sub_views = @selections.view.subviews.collect{|sub_view| sub_view.class}
    sub_views.should.include UITableView
    @selections.instance_variable_get(:@data).should == @radio_button_labels  
  end

  it "should add/remove scroll based on the data count" do
    @selections.should.receive(:remove_table_scroll)
    @selections.viewDidLoad
    @selections.frame.size.stub!(:height).and_return(ControlVariables::MaximumRadioButtonTableHeight)
    @selections.should.not.receive(:remove_table_scroll)
    @selections.viewDidLoad
  end

end
