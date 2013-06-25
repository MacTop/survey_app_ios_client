describe "Radio Buttons" do
  before do
    @radio_button_labels = ['red', 'green', 'blue']
    new_frame = CGRectMake(0,ControlVariables::QuestionMargin, 300 ,250)
    @radio_buttons = RadioButtons.new(data: ['red','green','blue'], frame: new_frame)
    @radio_buttons.viewDidLoad
  end
  
  it "should have a instance of TableView" do
    sub_views = @radio_buttons.view.subviews.collect{|sub_view| sub_view.class}
    sub_views.should.include UITableView
    @radio_buttons.instance_variable_get(:@data).should == @radio_button_labels  
  end

  it "should have image view and label view in the table cell" do
    table = @radio_buttons.instance_variable_get('@table')
    table.reloadData
    cell_subviews = table.visibleCells.first.contentView.subviews.collect{|sub_view| sub_view.class}
    cell_subviews.should.include UIImageView
    cell_subviews.should.include UILabel
  end

  it "should add/remove scroll based on the data count" do
    @radio_buttons.should.receive(:configure_table)
    @radio_buttons.data = ['asd', 'qwe']
    @radio_buttons.viewDidLoad
    @radio_buttons.should.not.receive(:configure_table)
    @radio_buttons.data = ['asd', 'qwe', 'wer', 'ert', 'tyu', 'tyu', 'dfg']
    @radio_buttons.viewDidLoad
  end
end
