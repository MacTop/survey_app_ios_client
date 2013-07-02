class RadioButtons < UIView #PM::Screen
  attr_accessor :data, :radio_options,  :radio_button_selection
  include Helpers
  
  def initialize(args = {})
    self.data = args[:data]
    self.radio_options = args[:radio_options]
    @expanded_data = []
    self.generate_expanded_data
    self.initWithFrame(CGRectMake(0,0, args[:frame].size.width, args[:frame].size.height))
    @table = UITableView.alloc.initWithFrame CGRectMake(0,0, args[:frame].size.width, args[:frame].size.height)
    @table.backgroundColor = ControlVariables::ScreenColor
    @table.setSeparatorStyle(UITableViewCellSeparatorStyleNone)
    subview(@table, :radio_buttons_table)
    @table.dataSource = self
    @table.delegate = self
    remove_table_scroll if self.frame.size.height < ControlVariables::MaximumRadioButtonTableHeight
    @radio_image_selected_view = get_radio_image_view_for("RadioButton-Selected.png")
    @selected_row = -1
  end

  def generate_expanded_data
    @radio_options.each do |radio_option|
      @expanded_data << FieldView.new({:question => radio_option.questions.to_a.first, :origin_y => 20 }) unless radio_option.questions.to_a.empty?
    end
  end
  
  def viewDidAppear(animated)
    new_frame = self.view.frame
    new_frame.size.height = self.frame.size.height
    self.view.frame = new_frame
  end

  def remove_table_scroll
    @table.bounces = false
    @table.scrollEnabled = false
    @table.showsVerticalScrollIndicator = false
  end

  def get_radio_image_view_for(image_name)
    radio_image = UIImage.imageNamed(image_name)
    radio_image_view = UIImageView.alloc.initWithImage(radio_image)
    radio_image_view.setFrame(CGRectMake(15, 12, 20,21))
    radio_image_view
  end
  
  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end
    cell.setSelectionStyle(UITableViewCellSelectionStyleNone)
    cell.contentView.subviews.removeViewsFromSuperview unless cell.contentView.subviews.empty?
    radio_image_view = get_radio_image_view_for("RadioButton-Unselected.png")
    cell.contentView.addSubview(radio_image_view)
    cell.contentView.addSubview(@data[indexPath.row])
    if @selected_row == indexPath.row
      cell.contentView.addSubview(@radio_image_selected_view)
      self.radio_button_selection = @data[indexPath.row].text
      unless self.radio_options[indexPath.row].questions.to_a.empty?
        cell.contentView.addSubview(@expanded_data[indexPath.row])
      end
    end
    cell    
  end

  def tableView(tableView, heightForRowAtIndexPath: indexPath)
    if @selected_row == indexPath.row
      @data[indexPath.row].frame.size.height + @expanded_data[indexPath.row].frame.size.height + ControlVariables::RadioCellPadding
    else
      @data[indexPath.row].frame.size.height + ControlVariables::RadioCellPadding
    end
  end
  
  def tableView(tableView, numberOfRowsInSection: section)
    self.data.count
  end

  def change_cell_highlight cell, label
    change_highlight cell.contentView, {:red => 1, :green => 1, :blue => 1, :alpha =>1 }
    change_highlight label, {:red => 1, :green => 1, :blue => 1, :alpha =>1}    
  end

  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    @selected_row = indexPath.row
    tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimationFade);
    cell = @table.cellForRowAtIndexPath(indexPath)
    change_cell_highlight cell, @data[indexPath.row]

    adjust_table_height
    
    cell
  end

  def adjust_table_height
    @table.reloadData
    
    adjust_height_to_table_content @table
    adjust_height_to_table_content self
    adjust_height_to_table_content self.superview
    
    self.superview.reset_field_frame
    
    submit_button = self.superview.viewWithTag(Tags::SubmitButtonView)
    if submit_button
      index =  self.superview.subviews.indexOfObject(submit_button)
      offset =  (@table.contentSize.height + ControlVariables::TableHeightMargin) - submit_button.frame.origin.y
      self.superview.update_input_field_height index, offset if index
    end   
  end

  def adjust_height_to_table_content view
    new_frame = view.frame
    new_frame.size.height = @table.contentSize.height
    view.frame = new_frame
  end
end
