class RadioButtons < PM::Screen
  attr_accessor :data, :frame, :radio_button_selection
  include Helpers
  
  def viewDidLoad
    @table = UITableView.alloc.initWithFrame CGRectMake(0,0, frame.size.width, frame.size.height)
    @table.backgroundColor = ControlVariables::ScreenColor
    @table.setSeparatorStyle(UITableViewCellSeparatorStyleNone)
    subview(@table, :radio_buttons_table)
    @table.dataSource = self
    @table.delegate = self
    remove_table_scroll if self.frame.size.height < ControlVariables::MaximumRadioButtonTableHeight
    @radio_image_selected_view = get_radio_image_view_for("RadioButton-Selected.png")
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

    radio_image_view = get_radio_image_view_for("RadioButton-Unselected.png")
    cell.contentView.addSubview(radio_image_view)

    cell.contentView.addSubview(@data[indexPath.row])
    cell    
  end

  def tableView(tableView, heightForRowAtIndexPath: indexPath)
    @data[indexPath.row].frame.size.height + ControlVariables::RadioCellPadding
  end
  
  def tableView(tableView, numberOfRowsInSection: section)
    self.data.count
  end

  def change_cell_highlight cell, label
    change_highlight cell.contentView, {:red => 1, :green => 1, :blue => 1, :alpha =>1 }
    change_highlight label, {:red => 1, :green => 1, :blue => 1, :alpha =>1}    
  end

  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    cell = @table.cellForRowAtIndexPath(indexPath)
    change_cell_highlight cell, @data[indexPath.row]
    cell.contentView.addSubview(@radio_image_selected_view)
    self.radio_button_selection = @data[indexPath.row].text
  end
end
