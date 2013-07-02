class SelectionField < PM::Screen
  attr_accessor :data, :frame
  include Helpers
  
  def viewDidLoad
    @table = UITableView.alloc.initWithFrame CGRectMake(0,0, frame.size.width, frame.size.height)
    @table.backgroundColor = ControlVariables::ScreenColor
    @table.setSeparatorStyle(UITableViewCellSeparatorStyleNone)
    subview(@table, :radio_buttons_table)
    @table.dataSource = self
    @table.delegate = self
    remove_table_scroll if self.frame.size.height < ControlVariables::MaximumRadioButtonTableHeight
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
  
  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end
    cell.setSelectionStyle(UITableViewCellSelectionStyleNone)
    cell    
  end

  def tableView(tableView, heightForRowAtIndexPath: indexPath)
    @data[indexPath.row].frame.size.height + ControlVariables::RadioCellPadding
  end
  
  def tableView(tableView, numberOfRowsInSection: section)
    self.data.count
  end

  def change_cell_highlight cell, label
    change_highlight cell.contentView, {:red => 1, :green => 1, :blue => 0.8, :alpha =>1 }
    change_highlight label, {:red => 1, :green => 1, :blue => 0.8, :alpha =>1}    
  end

  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
  end
end
