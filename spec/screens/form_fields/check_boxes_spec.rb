describe "Check Boxes" do
  before do
    @check_box_label1 = UILabel.alloc.initWithFrame(CGRectMake(44, 10, 250, 100))
    @check_box_label2 = UILabel.alloc.initWithFrame(CGRectMake(44, 10, 250, 100))
    @check_box_label3 = UILabel.alloc.initWithFrame(CGRectMake(44, 10, 250, 100))
    @check_box_labels = [@check_box_label1, @check_box_label2, @check_box_label3]
    @check_box_labels.each_with_index do |label, index|
      label.text = "Multi Choice#{index}"
    end
    new_frame = CGRectMake(0,ControlVariables::QuestionMargin, 300 ,200)
    @check_boxes = CheckBoxes.new(data: @check_box_labels, frame: new_frame)
  end
  
  it "should have image view and label view in the table cell" do
    table = @check_boxes.instance_variable_get('@table')
    table.reloadData
    cell_subviews = table.visibleCells.first.contentView.subviews.collect{|sub_view| sub_view.class}
    cell_subviews.should.include UIImageView
    cell_subviews.should.include UILabel
  end

  it "should return image view with passed alpha value" do
    image_view = @check_boxes.checkbox_image_for_cell("unchecked-checkbox.png", 1)
    image_view.class.should == UIImageView
    image_view.alpha.should == 1
  end

  it "should toggle the content returnd on click" do
    indexPath =  NSIndexPath.indexPathForRow(0, inSection: 0)
    table = @check_boxes.instance_variable_get('@table')
    table.reloadData
    @check_boxes.check_box_selection.length.should == 0
    @check_boxes.toggle_content_selection(indexPath)
    @check_boxes.check_box_selection.length.should == 1
    table.reloadData
    cell = table.cellForRowAtIndexPath(indexPath)
    cell.contentView.viewWithTag(Tags::CheckedImageView).alpha.should == 1
    @check_boxes.toggle_content_selection(indexPath)
    @check_boxes.check_box_selection.length.should == 0
    cell.contentView.viewWithTag(Tags::CheckedImageView).alpha.should == 0
  end

  it "should call toggle check box on selection" do
    table = @check_boxes.instance_variable_get('@table')
    table.reloadData
    indexpath =  NSIndexPath.indexPathForRow(0, inSection: 0)
    @check_boxes.should.receive(:toggle_content_selection)
    @check_boxes.tableView(table, didSelectRowAtIndexPath: indexpath)
  end
end
