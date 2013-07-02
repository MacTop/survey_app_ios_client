describe "Radio Buttons" do
  before do
    @radio_button_label1 = UILabel.alloc.initWithFrame(CGRectMake(44, 10, 250, 100))
    @radio_button_label2 = UILabel.alloc.initWithFrame(CGRectMake(44, 10, 250, 100))
    @radio_button_label3 = UILabel.alloc.initWithFrame(CGRectMake(44, 10, 250, 100))
    @radio_button_labels = [@radio_button_label1, @radio_button_label2, @radio_button_label3]
    @radio_button_labels.each_with_index do |label, index|
      label.text = "Radio option#{index}"
    end
    @new_frame = CGRectMake(0,ControlVariables::QuestionMargin, 300 ,200)
    @radio_buttons = RadioButtons.new({:data => @radio_button_labels, :frame => @new_frame, :radio_options => RadioOption.all})
    @radio_buttons.stub!(:adjust_table_height)
  end
  
  it "should have a instance of TableView" do
    sub_views = @radio_buttons.subviews.collect{|sub_view| sub_view.class}
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
    table = @radio_buttons.instance_variable_get('@table')
    table.bounces.should == false
    table.showsVerticalScrollIndicator.should == false
  
    new_frame = @new_frame
    new_frame.size.height = ControlVariables::MaximumRadioButtonTableHeight
    @radio_buttons = RadioButtons.new({:data => @radio_button_labels, :frame => new_frame, :radio_options => RadioOption.all})
    table = @radio_buttons.instance_variable_get('@table')
    table.bounces.should == true
    table.showsVerticalScrollIndicator.should == true
  end

  it "should return the selected radio button option" do
    table = @radio_buttons.instance_variable_get('@table')
    table.reloadData
    indexpath =  NSIndexPath.indexPathForRow(0, inSection: 0)
    @radio_buttons.tableView(table, didSelectRowAtIndexPath: indexpath)
    @radio_buttons.radio_button_selection.should ==  @radio_button_label1.text
    
    indexpath =  NSIndexPath.indexPathForRow(1, inSection: 0)
    @radio_buttons.tableView(table, didSelectRowAtIndexPath: indexpath)
    @radio_buttons.radio_button_selection.should.not ==  @radio_button_label1.text
  end

  it "should add a new question on selecting an option with sub question" do
    table = @radio_buttons.instance_variable_get('@table')
    table.reloadData
    indexpath =  NSIndexPath.indexPathForRow(0, inSection: 0)
    selected_cell = @radio_buttons.tableView(table, didSelectRowAtIndexPath: indexpath)
    subview_classes = selected_cell.contentView.subviews.collect { |subview| subview.class }
    subview_classes.should.include FieldView
   end
end
